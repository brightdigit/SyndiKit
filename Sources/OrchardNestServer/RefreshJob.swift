import Fluent
import NIO
import OrchardNestKit
import Queues
import Vapor

// Channel, String?, [FeedItem]

struct RefreshJob: Job {
  static let url = URL(string: "https://raw.githubusercontent.com/daveverwer/iOSDevDirectory/master/blogs.json")!
  typealias Payload = RefreshConfiguration

  func error(_ context: QueueContext, _ error: Error, _: RefreshConfiguration) -> EventLoopFuture<Void> {
    context.logger.report(error: error)
    return context.eventLoop.future()
  }

  func dequeue(_ context: QueueContext, _: RefreshConfiguration) -> EventLoopFuture<Void> {
    // context.application.http.client.configuration = HTTPClient.Configuration(tlsConfiguration: nil, redirectConfiguration: nil, timeout: HTTPClient.Configuration.Timeout(connect: .seconds(20), read: .seconds(20)), proxy: nil, ignoreUncleanSSLShutdown: true, decompression: .enabled(limit: .none))
//    context.application.http.client.configuration.ignoreUncleanSSLShutdown = true
//    context.application.http.client.configuration.decompression = .enabled(limit: .none)
//    context.application.http.client.configuration.timeout = .init(connect: .seconds(12), read: .seconds(12))
    let database = context.application.db

    let decoder = JSONDecoder()

    let sites: [LanguageContent]
    context.logger.info("downloading blog list...")
    do {
      let data = try Data(contentsOf: Self.url)
      sites = try decoder.decode([LanguageContent].self, from: data)
    } catch {
      return context.eventLoop.future(error: error)
    }

    let siteCatalogMap = SiteCatalogMap(sites: sites)

    let languages = siteCatalogMap.languages
    let categories = siteCatalogMap.categories
    let organizedSites = siteCatalogMap.organizedSites

    let futureLanguages = languages.map { Language.from($0, on: database) }.flatten(on: database.eventLoop)
    let futureCategories = categories.map { Category.from($0.key, on: database) }.flatten(on: database.eventLoop)

    let langMap = futureLanguages.map(Language.dictionary(from:))
    let catMap = futureCategories.map(Category.dictionary(from:))

    // need map to lang, cats

    let futureFeedResults: EventLoopFuture<[FeedResult]>
    futureFeedResults = langMap.and(catMap).flatMap { (maps) -> EventLoopFuture<[FeedResult]> in
      context.logger.info("downloading feeds...")
      let (langMap, catMap) = maps
      return organizedSites.map { orgSite in
        FeedChannel.parseSite(orgSite, using: context.application.client, on: context.eventLoop)
          .map { result in
            result.flatMap { FeedConfiguration.from(
              categorySlug: orgSite.categorySlug,
              languageCode: orgSite.languageCode,
              channel: $0,
              langMap: langMap,
              catMap: catMap
            )
            }
          }
      }.flatten(on: context.eventLoop)
    }

    let groupedResults = futureFeedResults.map { results -> ([FeedConfiguration], [FeedError]) in
      var errors = [FeedError]()
      var configurations = [FeedConfiguration]()
      results.forEach {
        switch $0 {
        case let .success(config): configurations.append(config)
        case let .failure(error): errors.append(error)
        }
      }
      return (configurations, errors)
    }

    groupedResults.whenSuccess { groupedResults in
      let errors = groupedResults.1
      for error in errors {
        context.logger.info("\(error.localizedDescription)")
      }
    }

    return database.transaction { database in
      let futureFeeds = groupedResults.map { $0.0 }.map {
        configs -> [FeedConfiguration] in
        let feeds = Dictionary(grouping: configs) { $0.channel.feedUrl }
        return feeds.compactMap { $0.value.first }
      }
      let currentChannels = futureFeeds.map { (args) -> [String] in
        args.map {
          $0.channel.feedUrl.absoluteString
        }
      }.flatMap { feedUrls in
        Channel.query(on: database).filter(\.$feedUrl ~~ feedUrls).all()
      }.map {
        Dictionary(uniqueKeysWithValues: ($0.map {
          ($0.feedUrl, $0)
        }))
      }

      let futureChannels = futureFeeds.and(currentChannels).map { (args) -> [ChannelFeedItemsConfiguration] in
        context.logger.info("beginning upserting channels...")
        let (feeds, currentChannels) = args

        return feeds.map { feedArgs in
          ChannelFeedItemsConfiguration(channels: currentChannels, feedArgs: feedArgs)
        }
      }.flatMap { (configurations) -> EventLoopFuture<[ChannelFeedItemsConfiguration]> in

        database.withConnection { (database) -> EventLoopFuture<[ChannelFeedItemsConfiguration]> in

          var results = [EventLoopFuture<ChannelFeedItemsConfiguration?>]()
          let promise = context.eventLoop.makePromise(of: Void.self)
          _ = context.eventLoop.scheduleRepeatedAsyncTask(initialDelay: .seconds(1), delay: .nanoseconds(20_000_000)) { (task: RepeatedTask) -> EventLoopFuture<Void> in
            guard results.count < configurations.count else {
              task.cancel(promise: promise)

              context.logger.info("finished upserting channels...")
              return context.eventLoop.makeSucceededFuture(())
            }
            let args = configurations[results.count]
            context.logger.info("saving \"\(args.channel.title)\"")
            let result = args.channel.save(on: database).transform(to: args).flatMapError { _ -> EventLoopFuture<ChannelFeedItemsConfiguration?> in
              database.eventLoop.future(ChannelFeedItemsConfiguration?.none)
            }
            results.append(result)
            return result.transform(to: ())
          }
          let finalResults = promise.futureResult.flatMap {
            results.flatten(on: context.eventLoop).mapEachCompact { $0 }
          }

          return finalResults
        }
      }
//      .flatMapEachCompact(on: context.eventLoop) { (args) -> EventLoopFuture<ChannelFeedItemsConfiguration?> in
//
//        context.logger.info("saving \"\(args.channel.title)\"")
//        return args.channel.save(on: database).transform(to: args).flatMapError { _ in database.eventLoop.future(ChannelFeedItemsConfiguration?.none) }
//      }

      // save youtube channels to channels
      let futYTChannels = futureChannels.mapEachCompact { (channel) -> YouTubeChannel? in
        channel.youtubeChannel
      }.flatMapEach(on: database.eventLoop) { newChannel in
        YouTubeChannel.upsert(newChannel, on: database)
      }

      // save entries to channels
      let futureEntries = futureChannels
        .flatMapEachThrowing { try $0.feedItems() }
        .map { $0.flatMap { $0 } }
        .flatMapEach(on: database.eventLoop) { (config) -> EventLoopFuture<FeedItemEntry> in
          FeedItemEntry.from(upsertOn: database, from: config)
        }

      // save videos to entries
      let futYTVideos = futureEntries.mapEachCompact { (entry) -> YoutubeVideo? in
        entry.youtubeVideo
      }.flatMapEach(on: database.eventLoop) { newVideo in
        YoutubeVideo.upsert(newVideo, on: database)
      }

      // save podcastepisodes to entries

      let futPodEpisodes = futureEntries.mapEachCompact { (entry) -> PodcastEpisode? in

        entry.podcastEpisode
      }.flatMapEach(on: database.eventLoop) { newEpisode in
        PodcastEpisode.upsert(newEpisode, on: database)
      }

      return futYTVideos.and(futYTChannels).and(futPodEpisodes).transform(to: ())
    }
  }
}

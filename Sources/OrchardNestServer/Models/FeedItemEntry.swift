import Fluent
import OrchardNestKit
import Vapor

struct FeedItemEntry {
  let entry: Entry
  let feedItem: FeedItem

  static func from(upsertOn database: Database, from config: FeedItemConfiguration) -> EventLoopFuture<FeedItemEntry> {
    Entry.query(on: database).filter(\.$feedId == config.feedItem.id).first().flatMap { foundEntry in
      let newEntry: Entry
      if let entry = foundEntry {
        newEntry = entry
      } else {
        newEntry = Entry()
      }

      newEntry.$channel.id = config.channelId
      newEntry.content = config.feedItem.content
      newEntry.feedId = config.feedItem.id
      newEntry.imageURL = config.feedItem.image?.absoluteString
      newEntry.publishedAt = config.feedItem.published
      newEntry.summary = config.feedItem.summary
      newEntry.title = config.feedItem.title
      newEntry.url = config.feedItem.url.absoluteString
      // context.logger.info("saving entry for \"\(config.feedItem.url)\"")
      return newEntry.save(on: database).transform(to: Self(entry: newEntry, feedItem: config.feedItem))
    }
  }
}

extension FeedItemEntry {
  var podcastEpisode: PodcastEpisode? {
    guard let id = entry.id, let audioURL = feedItem.audio else {
      return nil
    }
    return PodcastEpisode(entryId: id, audioURL: audioURL.absoluteString)
  }

  var youtubeVideo: YoutubeVideo? {
    guard let id = entry.id, let youtubeId = feedItem.ytId else {
      return nil
    }
    return YoutubeVideo(entryId: id, youtubeId: youtubeId)
  }
}

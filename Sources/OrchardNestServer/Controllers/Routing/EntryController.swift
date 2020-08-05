import Fluent
import OrchardNestKit
import Vapor

struct InvalidURLFormat: Error {}

extension String {
  func asURL() throws -> URL {
    guard let url = URL(string: self) else {
      throw InvalidURLFormat()
    }
    return url
  }
}

extension Entry {
  func category() throws -> EntryCategory {
    guard let category = EntryCategoryType(rawValue: channel.$category.id) else {
      return .development
    }

    if let url = podcastEpisode.flatMap({ URL(string: $0.audioURL) }) {
      return .podcasts(url)
    } else if let youtubeID = youtubeVideo?.youtubeId {
      return .youtube(youtubeID)
    } else {
      return try EntryCategory(type: category)
    }
  }
}

extension EntryChannel {
  init(channel: Channel) throws {
    try self.init(
      id: channel.requireID(),
      title: channel.title,
      siteURL: channel.siteUrl.asURL(),
      author: channel.author,
      twitterHandle: channel.twitterHandle,
      imageURL: channel.imageURL?.asURL()
    )
  }
}

extension EntryItem {
  init(entry: Entry) throws {
    try self.init(
      id: entry.requireID(),
      channel: EntryChannel(channel: entry.channel),
      category: entry.category(),
      feedId: entry.feedId,
      title: entry.title,
      summary: entry.summary,
      url: entry.url.asURL(),
      imageURL: entry.imageURL?.asURL(),
      publishedAt: entry.publishedAt
    )
  }
}

struct EntryController {
  func list(req: Request) -> EventLoopFuture<Page<EntryItem>> {
    return Entry.query(on: req.db)
      .sort(\.$publishedAt, .descending)
      .with(\.$channel)
      .paginate(for: req)
      .flatMapThrowing { (page: Page<Entry>) -> Page<EntryItem> in
        try page.map { (entry: Entry) -> EntryItem in
          try EntryItem(entry: entry)
        }
      }
  }
}

extension EntryController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    routes.get("", use: list)
  }
}

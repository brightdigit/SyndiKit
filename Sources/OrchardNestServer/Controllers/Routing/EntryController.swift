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

extension EntryChannel {
  init(channel: Channel) throws {
    try self.init(
      id: channel.requireID(),
      title: channel.title,
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

import Fluent
import OrchardNestKit
import Vapor

struct EntryController {
  static func entries(from database: Database) -> QueryBuilder<Entry> {
    return Entry.query(on: database).with(\.$channel) { builder in
      builder.with(\.$podcasts).with(\.$youtubeChannels)
    }
    .join(parent: \.$channel)
    .with(\.$podcastEpisodes)
    .join(children: \.$podcastEpisodes, method: .left)
    .with(\.$youtubeVideos)
    .join(children: \.$youtubeVideos, method: .left)
    .sort(\.$publishedAt, .descending)
  }

  func list(req: Request) -> EventLoopFuture<Page<EntryItem>> {
    return Self.entries(from: req.db)
      .paginate(for: req)
      .flatMapThrowing { (page: Page<Entry>) -> Page<EntryItem> in
        try page.map { (entry: Entry) -> EntryItem in
          try EntryItem(entry: entry)
        }
      }
  }

  func latest(req: Request) -> EventLoopFuture<Page<EntryItem>> {
    return Self.entries(from: req.db)
      .join(LatestEntry.self, on: \Entry.$id == \LatestEntry.$id)
      .filter(Channel.self, \Channel.$category.$id != "updates")
      .filter(Channel.self, \Channel.$language.$id == "en")
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
    routes.get("latest", use: latest)
  }
}

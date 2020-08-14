import Fluent
import OrchardNestKit
import Vapor

struct ChannelController {
  func entries(req: Request) -> EventLoopFuture<Page<EntryItem>> {
    guard let channel = req.parameters.get("channel").flatMap({ $0.base32UUID }) else {
      return req.eventLoop.makeFailedFuture(Abort(.notFound))
    }

    return EntryController.entries(from: req.db)
      .filter(Channel.self, \Channel.$id == channel)
      .paginate(for: req)
      .flatMapThrowing { (page: Page<Entry>) -> Page<EntryItem> in
        try page.map { (entry: Entry) -> EntryItem in
          try EntryItem(entry: entry)
        }
      }
  }
}

extension ChannelController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    routes.get(":channel", "entries", use: entries)
  }
}

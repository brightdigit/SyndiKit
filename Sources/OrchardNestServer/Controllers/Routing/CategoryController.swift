import Fluent
import OrchardNestKit
import Vapor

struct CategoryController {
  func entries(req: Request) -> EventLoopFuture<Page<EntryItem>> {
    guard let category = req.parameters.get("category") else {
      return req.eventLoop.makeFailedFuture(Abort(.notFound))
    }

    return EntryController.entries(from: req.db)
      .filter(Channel.self, \Channel.$category.$id == category)
      .filter(Channel.self, \Channel.$language.$id == "en")
      .paginate(for: req)
      .flatMapThrowing { (page: Page<Entry>) -> Page<EntryItem> in
        try page.map { (entry: Entry) -> EntryItem in
          try EntryItem(entry: entry)
        }
      }
  }
}

extension CategoryController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    routes.get(":category", "entries", use: entries)
  }
}

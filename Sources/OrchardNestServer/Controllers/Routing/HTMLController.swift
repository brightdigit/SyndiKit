import Fluent
import OrchardNestKit
import Plot
import Vapor

struct HTMLController {
  func index(req: Request) -> EventLoopFuture<HTML> {
    return Entry.query(on: req.db)
      .sort(\.$publishedAt, .descending)
      .with(\.$channel)
      .paginate(for: req)
      .flatMapThrowing { (page: Page<Entry>) -> Page<EntryItem> in
        try page.map { (entry: Entry) -> EntryItem in
          try EntryItem(entry: entry)
        }
      }.map { (page) -> HTML in
        HTML(
          .head(
            .title("My website"),
            .stylesheet("styles.css")
          ),
          .body(
            .div(
              .h1("My website"),
              .p("Writing HTML in Swift is pretty great!")
            ),
            .ul(.forEach(page.items) {
              .li(.class("name"), .text($0.title))
            })
          )
        )
      }
  }
}

extension HTMLController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    routes.get("", use: index)
  }
}

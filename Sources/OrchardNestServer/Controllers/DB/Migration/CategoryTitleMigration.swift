import Fluent
import Vapor

struct CategoryTitleMigration: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema(CategoryTitle.schema)
      .id()
      .field("code", .string, .references(Language.schema, "code"))
      .field("slug", .string, .references(Category.schema, "slug"))
      .field("title", .string, .required)
      .unique(on: "code", "slug")
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(CategoryTitle.schema).delete()
  }
}

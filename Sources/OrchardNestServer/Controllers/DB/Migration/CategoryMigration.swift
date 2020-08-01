import Fluent
import Vapor

struct CategoryMigration: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema(Category.schema)
      .field("slug", .string, .identifier(auto: false))
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(Category.schema).delete()
  }
}

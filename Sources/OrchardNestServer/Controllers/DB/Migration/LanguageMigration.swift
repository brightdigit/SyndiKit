import Fluent
import Vapor

struct LanguageMigration: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema(Language.schema)
      .field("code", .string, .identifier(auto: false))
      .field("title", .string, .required)
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(Language.schema).delete()
  }
}

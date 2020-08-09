import Fluent
import Vapor

struct EntryMigration: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema(Entry.schema)
      .id()
      .field("channel_id", .uuid, .required)
      .field("feed_id", .string, .required)
      .field("title", .string, .required)
      .field("summary", .string, .required)
      .field("content", .string)
      .field("url", .string, .required)
      .field("image", .string)
      .field("published_at", .datetime, .required)
      .field("created_at", .datetime, .required)
      .field("updated_at", .datetime, .required)
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(Entry.schema).delete()
  }
}

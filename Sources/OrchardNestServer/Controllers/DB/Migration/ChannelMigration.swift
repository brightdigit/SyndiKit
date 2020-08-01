import Fluent
import Vapor

struct ChannelMigration: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema(Channel.schema)
      .id()
      .field("language_code", .string, .references(Language.schema, "code"))
      .field("category_slug", .string, .references(Category.schema, "slug"))
      .field("title", .string, .required)
      .field("subtitle", .string)
      .field("author", .string, .required)
      .field("site_url", .string, .required)
      .field("feed_url", .string, .required)
      .field("twitter_handle", .string)
      .field("image", .string)
      .field("published_at", .datetime, .required)
      .field("created_at", .datetime, .required)
      .field("updated_at", .datetime, .required)
      .unique(on: "site_url")
      .unique(on: "feed_url")
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(Channel.schema).delete()
  }
}

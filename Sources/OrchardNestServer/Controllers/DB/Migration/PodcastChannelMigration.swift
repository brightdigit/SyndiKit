import Fluent
import Vapor

struct PodcastChannelMigration: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema(PodcastChannel.schema)
      .field("channel_id", .uuid, .identifier(auto: false), .references(Channel.schema, .id))
      .field("apple_id", .int, .required)
      .unique(on: "apple_id")
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(PodcastChannel.schema).delete()
  }
}

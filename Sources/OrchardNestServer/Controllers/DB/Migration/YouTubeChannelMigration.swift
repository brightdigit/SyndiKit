import Fluent
import Vapor

struct YouTubeChannelMigration: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema(YouTubeChannel.schema)
      .field("channel_id", .uuid, .references(Channel.schema, .id))
      .field("youtube_id", .string, .required)
      .unique(on: "youtube_id")
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(YouTubeChannel.schema).delete()
  }
}

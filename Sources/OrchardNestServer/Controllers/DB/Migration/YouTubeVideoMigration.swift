import Fluent
import Vapor

struct YouTubeVideoMigration: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema(YoutubeVideo.schema)
      .field("entry_id", .uuid, .identifier(auto: false), .references(Entry.schema, .id))
      .field("youtube_id", .string, .required)
      .unique(on: "youtube_id")
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(YoutubeVideo.schema).delete()
  }
}

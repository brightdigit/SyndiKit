import Fluent
import Vapor

final class Entry: Model {
  static var schema = "entries"

  init() {}

  @ID()
  var id: UUID?

  @Parent(key: "channel_id")
  var channel: Channel

  @Field(key: "feed_id")
  var feedId: String

  @Field(key: "title")
  var title: String

  @Field(key: "summary")
  var summary: String

  @OptionalField(key: "content")
  var content: String?

  @Field(key: "url")
  var url: URL

  @OptionalField(key: "image")
  var image: URL?

  @Field(key: "published_at")
  var publishedAt: Date

  // When this Planet was created.
  @Timestamp(key: "created_at", on: .create)
  var createdAt: Date?

  // When this Planet was last updated.
  @Timestamp(key: "updated_at", on: .update)
  var updatedAt: Date?
}

// public let ytId: String?
// public let audio: URL?

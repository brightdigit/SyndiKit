import Fluent
import Vapor

final class Channel: Model {
  static var schema = "channels"

  init() {}

  @ID()
  var id: UUID?

  @Field(key: "title")
  var title: String

  @Parent(key: "language_code")
  var language: Language

  @Parent(key: "category_slug")
  var category: Category

  @OptionalField(key: "subtitle")
  var subtitle: String?

  @Field(key: "author")
  var author: String

  @Field(key: "site_url")
  var siteUrl: URL

  @Field(key: "feed_url")
  var feedUrl: URL

  @OptionalField(key: "twitter_handle")
  var twitterHandle: String?

  @OptionalField(key: "image")
  var image: URL?

  @Field(key: "published_at")
  var updated: Date

  // When this Planet was created.
  @Timestamp(key: "created_at", on: .create)
  var createdAt: Date?

  // When this Planet was last updated.
  @Timestamp(key: "updated_at", on: .update)
  var updatedAt: Date?
}

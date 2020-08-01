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
  var siteUrl: String

  @Field(key: "feed_url")
  var feedUrl: String

  @OptionalField(key: "twitter_handle")
  var twitterHandle: String?

  @OptionalField(key: "image")
  var imageURL: String?

  @Field(key: "published_at")
  var publishedAt: Date

  // When this Planet was created.
  @Timestamp(key: "created_at", on: .create)
  var createdAt: Date?

  // When this Planet was last updated.
  @Timestamp(key: "updated_at", on: .update)
  var updatedAt: Date?

  @Children(for: \.$channel)
  var entries: [Entry]
}

extension Channel: Validatable {
  static func validations(_ validations: inout Validations) {
    validations.add("siteUrl", as: URL.self)
    validations.add("feedUrl", as: URL.self)
    validations.add("imageURL", as: URL.self)
  }
}

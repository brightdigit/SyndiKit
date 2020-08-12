import Fluent
import Vapor

final class Entry: Model, Content {
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
  var url: String

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

  @Children(for: \.$entry)
  var podcastEpisodes: [PodcastEpisode]

  var podcastEpisode: PodcastEpisode? {
    return $podcastEpisodes.value?.first
  }

  @Children(for: \.$entry)
  var youtubeVideos: [YoutubeVideo]

  var youtubeVideo: YoutubeVideo? {
    return $youtubeVideos.value?.first
  }
}

extension Entry: Validatable {
  static func validations(_ validations: inout Validations) {
    validations.add("url", as: URL.self)
    validations.add("imageURL", as: URL.self)
  }
}

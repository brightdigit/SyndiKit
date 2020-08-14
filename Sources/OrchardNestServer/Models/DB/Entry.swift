import Fluent
import OrchardNestKit
import Vapor

public final class Entry: Model, Content {
  public static var schema = "entries"

  public init() {}

  @ID()
  public var id: UUID?

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
  public static func validations(_ validations: inout Validations) {
    validations.add("url", as: URL.self)
    validations.add("imageURL", as: URL.self)
  }
}

public extension Entry {
  func category() throws -> EntryCategory {
    guard let category = EntryCategoryType(rawValue: channel.$category.id) else {
      return .development
    }

    if let podcastEpisode = self.podcastEpisode, let url = URL(string: podcastEpisode.audioURL) {
      return .podcasts(url, podcastEpisode.seconds)
    } else if let youtubeVideo = self.youtubeVideo {
      return .youtube(youtubeVideo.youtubeId, youtubeVideo.seconds)
    } else {
      return try EntryCategory(type: category)
    }
  }
}

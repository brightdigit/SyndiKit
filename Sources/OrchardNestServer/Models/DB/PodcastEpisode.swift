import Fluent
import Vapor

final class PodcastEpisode: Model {
  static var schema = "podcast_episodes"

  init() {}

  @ID(custom: "entry_id", generatedBy: .user)
  var id: UUID?

  @Field(key: "audio")
  var audio: URL
}

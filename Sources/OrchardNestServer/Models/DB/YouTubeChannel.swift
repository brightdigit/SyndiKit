import Fluent
import Vapor

final class YouTubeChannel: Model {
  static var schema = "youtube_channels"

  init() {}

  @ID(custom: "channel_id", generatedBy: .user)
  var id: String?

  @Field(key: "youtube_id")
  var ytId: String
}

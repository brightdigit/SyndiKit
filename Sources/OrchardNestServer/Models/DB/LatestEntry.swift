import Fluent
import Vapor

final class LatestEntry: Model {
  static let schema = "latest_entries"

  @ID()
  var id: UUID?

  @Field(key: "channel_id")
  var channelId: UUID
}

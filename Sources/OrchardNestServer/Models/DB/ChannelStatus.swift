import Fluent
import Vapor

enum ChannelStatusType: String, Codable, CaseIterable {
  case ignore
}

final class ChannelStatus: Model {
  static var schema = "channel_statuses"

  init() {}

  init(feedUrl: URL, status: ChannelStatusType) {
    id = feedUrl.absoluteString
    self.status = status
  }

  @ID(custom: "feed_url", generatedBy: .user)
  var id: String?

  @Enum(key: "status")
  var status: ChannelStatusType
}

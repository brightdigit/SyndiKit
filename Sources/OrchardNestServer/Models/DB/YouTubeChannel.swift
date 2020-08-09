import Fluent
import Vapor

final class YouTubeChannel: Model {
  static var schema = "youtube_channels"

  init() {}

  init(channelId: UUID, youtubeId: String) {
    id = channelId
    self.youtubeId = youtubeId
  }

  @ID(custom: "channel_id", generatedBy: .user)
  var id: UUID?

  @Field(key: "youtube_id")
  var youtubeId: String

  @Parent(key: "channel_id")
  var channel: Channel
}

extension YouTubeChannel {
  static func upsert(_ newChannel: YouTubeChannel, on database: Database) -> EventLoopFuture<Void> {
    YouTubeChannel.find(newChannel.id, on: database)
      .optionalMap { $0.youtubeId == newChannel.youtubeId ? $0 : nil }
      .flatMap { (channel) -> EventLoopFuture<Void> in
        guard let channelId = newChannel.id, channel == nil else {
          return database.eventLoop.makeSucceededFuture(())
        }

        return YouTubeChannel.query(on: database).group(.or) {
          $0.filter(\.$id == channelId).filter(\.$youtubeId == newChannel.youtubeId)
        }.all().flatMapEach(on: database.eventLoop) { channel in
          channel.delete(on: database)
        }.flatMap { _ in
          // context.logger.info("saving yt channel \"\(newChannel.youtubeId)\"")
          newChannel.save(on: database)
        }
      }
  }
}

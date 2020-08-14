import Fluent
import Vapor

final class PodcastChannel: Model {
  static var schema = "podcast_channels"

  init() {}

  init(channelId: UUID, appleId: Int) {
    id = channelId
    self.appleId = appleId
  }

  @ID(custom: "channel_id", generatedBy: .user)
  var id: UUID?

  @Field(key: "apple_id")
  var appleId: Int

  @Parent(key: "channel_id")
  var channel: Channel
}

extension PodcastChannel {
  static func upsert(_ newChannel: PodcastChannel, on database: Database) -> EventLoopFuture<Void> {
    PodcastChannel.find(newChannel.id, on: database)
      .optionalMap { $0.appleId == newChannel.appleId ? $0 : nil }
      .flatMap { (channel) -> EventLoopFuture<Void> in
        guard let channelId = newChannel.id, channel == nil else {
          return database.eventLoop.makeSucceededFuture(())
        }

        return PodcastChannel.query(on: database).group(.or) {
          $0.filter(\.$id == channelId).filter(\.$appleId == newChannel.appleId)
        }.all().flatMapEach(on: database.eventLoop) { channel in
          channel.delete(on: database)
        }.flatMap { _ in
          newChannel.save(on: database)
        }
      }
  }
}

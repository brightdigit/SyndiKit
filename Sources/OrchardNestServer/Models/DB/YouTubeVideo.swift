import Fluent
import Vapor

final class YoutubeVideo: Model {
  static var schema = "youtube_videos"

  init() {}

  init(entryId: UUID, youtubeId: String) {
    id = entryId
    self.youtubeId = youtubeId
  }

  @ID(custom: "entry_id", generatedBy: .user)
  var id: UUID?

  @Field(key: "youtube_id")
  var youtubeId: String
}

extension YoutubeVideo {
  static func upsert(_ newVideo: YoutubeVideo, on database: Database) -> EventLoopFuture<Void> {
    return YoutubeVideo.find(newVideo.id, on: database)
      .optionalMap { $0.youtubeId == newVideo.youtubeId ? $0 : nil }
      .flatMap { (video) -> EventLoopFuture<Void> in
        guard let entryId = newVideo.id, video == nil else {
          return database.eventLoop.makeSucceededFuture(())
        }

        return YoutubeVideo.query(on: database).group(.or) {
          $0.filter(\.$id == entryId).filter(\.$youtubeId == newVideo.youtubeId)
        }.all().flatMapEach(on: database.eventLoop) { channel in
          channel.delete(on: database)
        }.flatMap { _ in
          // context.logger.info("saving yt video \"\(newVideo.youtubeId)\"")
          newVideo.save(on: database)
        }
      }
  }
}

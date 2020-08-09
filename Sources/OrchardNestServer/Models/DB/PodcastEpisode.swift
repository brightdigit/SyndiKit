import Fluent
import Vapor

final class PodcastEpisode: Model {
  static var schema = "podcast_episodes"

  init() {}

  init(entryId: UUID, audioURL: String) {
    id = entryId
    self.audioURL = audioURL
  }

  @ID(custom: "entry_id", generatedBy: .user)
  var id: UUID?

  @Field(key: "audio")
  var audioURL: String

  @Parent(key: "entry_id")
  var entry: Entry
}

extension PodcastEpisode: Validatable {
  static func validations(_ validations: inout Validations) {
    validations.add("audioURL", as: URL.self)
  }
}

extension PodcastEpisode {
  static func upsert(_ newEpisode: PodcastEpisode, on database: Database) -> EventLoopFuture<Void> {
    return PodcastEpisode.find(newEpisode.id, on: database)
      .flatMap { (episode) -> EventLoopFuture<Void> in
        let savingEpisode: PodcastEpisode
        if let oldEpisode = episode {
          oldEpisode.audioURL = newEpisode.audioURL
          savingEpisode = oldEpisode
        } else {
          savingEpisode = newEpisode
        }
        // context.logger.info("saving podcast episode \"\(savingEpisode.audioURL)\"")
        return savingEpisode.save(on: database)
      }
  }
}

import Foundation

/// A struct representing a podcast transcript.
public struct PodcastTranscript: Codable, Equatable {
  /// The coding keys for the podcast transcript.
  public enum CodingKeys: String, CodingKey {
    case url
    case type
    case language
    case rel
  }

  /// The relationship between the podcast transcript and the podcast.
  public enum Relationship: String, Codable {
    case captions
  }

  /// The URL of the podcast transcript.
  public let url: URL

  /// The MIME type of the podcast transcript.
  public let type: MimeType

  /// The language of the podcast transcript.
  public let language: String?

  /// The relationship of the podcast transcript.
  public let rel: Relationship?
}

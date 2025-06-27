import Foundation

/// A struct representing chapters of a podcast.
public struct PodcastChapters: Codable, Equatable, Sendable {
  /// The coding keys for encoding and decoding.
  public enum CodingKeys: String, CodingKey {
    case url
    case type
  }

  /// The URL of the chapter file.
  public let url: URL

  /// The MIME type of the chapter file.
  public let type: MimeType
}

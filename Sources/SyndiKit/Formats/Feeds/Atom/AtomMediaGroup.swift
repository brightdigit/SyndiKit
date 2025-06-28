import Foundation

/// A group of media elements in an Atom feed.
public struct AtomMediaGroup: Codable, Sendable {
  /// Coding keys for encoding and decoding.
  public enum CodingKeys: String, CodingKey {
    case title = "media:title"
    case descriptions = "media:description"
    case contents = "media:content"
    case thumbnails = "media:thumbnail"
  }

  /// The title of the media group.
  public let title: String?

  /// The media elements within the group.
  public let contents: [AtomMedia]

  /// The thumbnail images associated with the media group.
  public let thumbnails: [AtomMedia]

  /// The descriptions of the media group.
  public let descriptions: [String]
}

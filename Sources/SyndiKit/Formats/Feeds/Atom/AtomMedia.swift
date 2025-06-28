#if swift(>=5.7)
  @preconcurrency import Foundation
#else
  import Foundation
#endif

/// A struct representing an Atom category.
/// Media structure which enables content publishers and bloggers
/// to syndicate multimedia content such as TV and video clips, movies, images and audio.
///
/// For more details, check out
/// [the Media RSS Specification](https://www.rssboard.org/media-rss).
/// - SeeAlso: ``EntryCategory``
public struct AtomMedia: Codable, Sendable {
  /// A struct representing an Atom category.
  ///   The type of object.
  ///
  ///   While this attribute can at times seem redundant if type is supplied,
  ///   it is included because it simplifies decision making on the reader side,
  ///   as well as flushes out any ambiguities between MIME type and object type.
  ///   It is an optional attribute.
  /// - SeeAlso: ``EntryCategory``
  public let url: URL

  /// The direct URL to the media object.
  public let medium: String?

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    url = try container.decode(UTF8EncodedURL.self, forKey: .url).value
    medium = try container.decodeIfPresent(String.self, forKey: .medium)
  }
}

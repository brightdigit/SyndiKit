import Foundation

/// Media structure which enables
/// content publishers and bloggers to syndicate multimedia content
/// such as TV and video clips, movies, images and audio.
///
/// Fore more detils check out
/// [the Media RSS Specification](https://www.rssboard.org/media-rss).
public struct AtomMedia: Codable {
  /// The type of object.
  ///
  ///  While this attribute can at times seem redundant if type is supplied,
  ///  it is included because it simplifies decision making on the reader side,
  ///  as well as flushes out any ambiguities between MIME type and object type.
  ///  It is an optional attribute.
  public let url: URL

  /// The direct URL to the media object.
  public let medium: String?
  
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.url = try container.decode(UTF8EncodedURL.self, forKey: .url).value
    self.medium = try container.decodeIfPresent(String.self, forKey: .medium)
  }
}

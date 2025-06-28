#if swift(>=5.7)
  @preconcurrency import Foundation
#else
  import Foundation
#endif

/// A struct representing funding information for a podcast.
public struct PodcastFunding: Codable, Equatable, Sendable {
  /// The coding keys used for encoding and decoding.
  public enum CodingKeys: String, CodingKey {
    case url
    case description = ""
  }

  /// The URL for the funding source.
  public let url: URL

  /// A description of the funding source.
  public let description: String?
}

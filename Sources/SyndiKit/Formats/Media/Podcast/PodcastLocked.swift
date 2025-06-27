import Foundation

/// A struct representing a locked podcast.
public struct PodcastLocked: Codable, Equatable, Sendable {
  /// Coding keys for encoding and decoding.
  public enum CodingKeys: String, CodingKey {
    case owner
    case isLocked = ""
  }

  /// The owner of the podcast.
  public let owner: String?

  /// Indicates whether the podcast is locked.
  public let isLocked: Bool

  /// Initializes a new instance of ``PodcastLocked`` from a decoder.
  ///
  /// - Parameter decoder: The decoder to read data from.
  /// - Throws: An error if the decoding process fails.
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    owner = try container.decodeIfPresent(String.self, forKey: .owner)
    isLocked = try container.decode(String.self, forKey: .isLocked).lowercased() == "yes"
  }
}

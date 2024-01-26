import Foundation

/// A struct representing a season of a podcast.
public struct PodcastSeason: Codable, Equatable {
  /// The coding keys for the ``PodcastSeason`` struct.
  public enum CodingKeys: String, CodingKey {
    case name
    case number = ""
  }

  /// The name of the season.
  public let name: String?

  /// The number of the season.
  public let number: Int
}

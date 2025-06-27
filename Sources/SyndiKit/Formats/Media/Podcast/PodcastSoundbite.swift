import Foundation

/// A struct representing a soundbite from a podcast.
public struct PodcastSoundbite: Codable, Equatable, Sendable {
  /// The coding keys used for encoding and decoding.
  public enum CodingKeys: String, CodingKey {
    case startTime
    case duration

    case title = ""
  }

  /// The start time of the soundbite.
  public let startTime: TimeInterval

  /// The duration of the soundbite.
  public let duration: TimeInterval

  /// The title of the soundbite.
  public let title: String?
}

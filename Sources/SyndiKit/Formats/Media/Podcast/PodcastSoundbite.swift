import Foundation

/// ```xml
/// <podcast:soundbite
///   startTime="1234.5"
///   duration="42.25"
/// >
///   Why the Podcast Namespace Matters
/// </podcast:soundbite>
/// ```
/// ```xml
/// <podcast:soundbite 
///   startTime="73.0"
///   duration="60.0"
/// />
/// ```
public struct PodcastSoundbite: Codable, Equatable {
  public let startTime: TimeInterval
  public let duration: TimeInterval

  public let title: String?

  enum CodingKeys: String, CodingKey {
    case startTime
    case duration

    case title = ""
  }
}

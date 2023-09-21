import Foundation

public struct PodcastSoundbite: Codable {
  public let startTime: TimeInterval
  public let duration: TimeInterval

  public let value: String?

  enum CodingKeys: String, CodingKey {
    case startTime
    case duration

    case value = ""
  }
}

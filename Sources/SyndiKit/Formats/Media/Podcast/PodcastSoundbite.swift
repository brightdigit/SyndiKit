import Foundation

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

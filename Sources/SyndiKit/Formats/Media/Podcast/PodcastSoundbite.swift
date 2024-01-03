import Foundation

public struct PodcastSoundbite: Codable, Equatable {
  public enum CodingKeys: String, CodingKey {
    case startTime
    case duration

    case title = ""
  }
  
  public let startTime: TimeInterval
  public let duration: TimeInterval

  public let title: String?

}

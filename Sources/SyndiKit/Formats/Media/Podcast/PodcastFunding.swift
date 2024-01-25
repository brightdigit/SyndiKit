import Foundation

public struct PodcastFunding: Codable, Equatable {
  public enum CodingKeys: String, CodingKey {
    case url
    case description = ""
  }

  public let url: URL
  public let description: String?
}

import Foundation

public struct PodcastFunding: Codable, Equatable {
  public let url: URL
  public let description: String?

  enum CodingKeys: String, CodingKey {
    case url
    case description = ""
  }
}

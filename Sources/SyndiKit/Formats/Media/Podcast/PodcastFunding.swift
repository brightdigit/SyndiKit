import Foundation

/// <podcast:funding url="https://www.example.com/donations">Support the show!</podcast:funding>g
public struct PodcastFunding: Codable {
  public let url: URL
  public let description: String?

  enum CodingKeys: String, CodingKey {
    case url
    case description = ""
  }
}

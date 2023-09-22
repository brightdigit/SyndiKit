import Foundation

/// <podcast:chapters url="https://example.com/episode1/chapters.json" type="application/json+chapters" />
public struct PodcastChapters: Codable {
  public let url: URL
  public let type: String

  enum CodingKeys: String, CodingKey {
    case url
    case type
  }
}

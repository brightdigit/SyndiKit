import Foundation

public struct PodcastChapters: Codable {
  public let url: URL
  public let type: String

  enum CodingKeys: String, CodingKey {
    case url
    case type
  }
}

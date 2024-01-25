import Foundation

public struct PodcastChapters: Codable, Equatable {
  public enum CodingKeys: String, CodingKey {
    case url
    case type
  }

  public let url: URL
  public let type: MimeType
}

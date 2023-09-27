import Foundation

public struct PodcastChapters: Codable, Equatable {
  public let url: URL
  public let type: MimeType

  enum CodingKeys: String, CodingKey {
    case url
    case type
  }
}

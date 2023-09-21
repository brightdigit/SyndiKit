import Foundation

public struct PodcastTranscript: Codable {
  public let url: URL
  public let type: String
  public let language: String?
  public let rel: String?

  enum CodingKeys: String, CodingKey {
    case url
    case type
    case language
    case rel
  }
}

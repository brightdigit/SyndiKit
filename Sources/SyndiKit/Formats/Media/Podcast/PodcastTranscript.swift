import Foundation

public struct PodcastTranscript: Codable, Equatable {
  public enum Relationship: String, Codable {
    case captions
  }

  public let url: URL
  public let type: MimeType
  public let language: String?
  public let rel: Relationship?

  enum CodingKeys: String, CodingKey {
    case url
    case type
    case language
    case rel
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.url = try container.decode(URL.self, forKey: .url)
    self.language = try container.decodeIfPresent(String.self, forKey: .language)
    self.rel = try container.decodeIfPresent(Relationship.self, forKey: .rel)

    let typeStr = try container.decode(String.self, forKey: .type)
    self.type = MimeType(caseInsensitive: typeStr)
  }
}

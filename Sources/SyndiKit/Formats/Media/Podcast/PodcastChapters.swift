import Foundation

public struct PodcastChapters: Codable, Equatable {
  public let url: URL
  public let type: MimeType

  enum CodingKeys: String, CodingKey {
    case url
    case type
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.url = try container.decode(URL.self, forKey: .url)

    let typeStr = try container.decode(String.self, forKey: .type)
    self.type = MimeType(caseInsensitive: typeStr)
  }
}

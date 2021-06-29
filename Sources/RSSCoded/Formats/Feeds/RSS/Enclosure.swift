import Foundation

public struct Enclosure: Codable {
  let url: URL
  let type: String
  let length: Int?

  enum CodingKeys: String, CodingKey {
    case url
    case type
    case length
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Self.CodingKeys)
    url = try container.decode(URL.self, forKey: .url)
    type = try container.decode(String.self, forKey: .type)
    length = try? container.decode(Int.self, forKey: .length)
  }
}

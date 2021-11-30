import Foundation

public struct Enclosure: Codable {
  public let url: URL
  public let type: String
  public let length: Int?

  enum CodingKeys: String, CodingKey {
    case url
    case type
    case length
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Self.CodingKeys)
    url = try container.decode(URL.self, forKey: .url)
    type = try container.decode(String.self, forKey: .type)
    if container.contains(.length) {
      do {
        length = try container.decode(Int.self, forKey: .length)
      } catch {
        let lengthString = try container.decode(String.self, forKey: .length)
        if lengthString.isEmpty {
          length = nil
        } else if let length = Int(lengthString) {
          self.length = length
        } else {
          throw error
        }
      }
    } else {
      length = nil
    }
  }
}

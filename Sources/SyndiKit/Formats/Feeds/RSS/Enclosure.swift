import Foundation

public struct Enclosure: Codable {
  internal enum CodingKeys: String, CodingKey {
    case url
    case type
    case length
  }

  public let url: URL
  public let type: String
  public let length: Int?

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Self.CodingKeys.self)
    url = try container.decode(UTF8EncodedURL.self, forKey: .url).value
    type = try container.decode(String.self, forKey: .type)
    length = try Self.decodeLength(from: container)
  }

  private static func decodeLength(
    from container: KeyedDecodingContainer<CodingKeys>
  ) throws -> Int? {
    if container.contains(.length) {
      do {
        return try container.decode(Int.self, forKey: .length)
      } catch {
        let lengthString = try container.decode(String.self, forKey: .length)
        if lengthString.isEmpty {
          return nil
        } else if let length = Int(lengthString) {
          return length
        } else {
          throw error
        }
      }
    } else {
      return nil
    }
  }
}

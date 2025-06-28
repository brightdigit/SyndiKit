#if swift(>=5.7)
  @preconcurrency import Foundation
#else
  import Foundation
#endif

/// A struct representing an enclosure for a resource.
public struct Enclosure: Codable, Sendable {
  internal enum CodingKeys: String, CodingKey {
    case url
    case type
    case length
  }

  /// The URL of the enclosure.
  public let url: URL

  /// The type of the enclosure.
  public let type: String

  /// The length of the enclosure, if available.
  public let length: Int?

  /// Initializes a new ``Enclosure`` instance from a decoder.
  ///
  /// - Parameter decoder: The decoder to read data from.
  /// - Throws: An error if the decoding process fails.
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    url = try container.decode(UTF8EncodedURL.self, forKey: .url).value
    type = try container.decode(String.self, forKey: .type)
    length = try Self.decodeLength(from: container)
  }

  /// Decodes the length of the enclosure from the given container.
  ///
  /// - Parameter container: The container to decode from.
  /// - Returns: The length of the enclosure, or ``nil`` if not available.
  /// - Throws: An error if the decoding process fails.
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

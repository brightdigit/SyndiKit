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

  var imageURL: URL? {
    guard type.starts(with: "image/") else {
      return nil
    }

    return url
  }

  var audioURL: URL? {
    guard type.starts(with: "audio/") else {
      return nil
    }

    return url
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Self.CodingKeys)
    url = try container.decode(URL.self, forKey: .url)
    type = try container.decode(String.self, forKey: .type)
    length = try? container.decode(Int.self, forKey: .length)
  }
}

#if canImport(FeedKit)
  import FeedKit
  extension Enclosure {
    init?(element: RSSFeedItemEnclosure) {
      guard let url = element.attributes?.url.flatMap(URL.init(string:)) else {
        return nil
      }

      guard let type = element.attributes?.type else {
        return nil
      }

      self.url = url
      self.type = type
    }

    init?(element: AtomFeedEntryLink) {
      guard let url = element.attributes?.href.flatMap(URL.init(string:)) else {
        return nil
      }

      guard let type = element.attributes?.type else {
        return nil
      }

      self.url = url
      self.type = type
    }
  }
#endif

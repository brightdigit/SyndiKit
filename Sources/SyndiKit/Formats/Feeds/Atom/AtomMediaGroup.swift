import Foundation

public struct AtomMediaGroup: Codable {
  public let title: String?
  public let contents: [AtomMedia]
  public let thumbnails: [AtomMedia]
  public let descriptions: [String]

  enum CodingKeys: String, CodingKey {
    case title = "media:title"
    case descriptions = "media:description"
    case contents = "media:content"
    case thumbnails = "media:thumbnail"
  }
}

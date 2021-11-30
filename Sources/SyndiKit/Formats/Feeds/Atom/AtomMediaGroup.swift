import Foundation

public struct AtomMediaGroup: Codable {
  let title: String?
  let contents: [AtomMedia]
  let thumbnails: [AtomMedia]
  let descriptions: [String]

  enum CodingKeys: String, CodingKey {
    case title = "media:title"
    case descriptions = "media:description"
    case contents = "media:content"
    case thumbnails = "media:thumbnail"
  }
}

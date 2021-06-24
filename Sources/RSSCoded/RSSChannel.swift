import Foundation
struct RSSChannel: Codable {
  let title: String
  let link: URL
  let description: String?
  let lastBuildDate: Date?
  let syUpdatePeriod: String?
  let syUpdateFrequency: String?
  let item: [RSSItem]
  let itunesAuthor: String?
  let itunesImage: String?
  let itunesOwner: iTunesOwner?
  enum CodingKeys: String, CodingKey {
    case title
    case link
    case description
    case lastBuildDate
    case syUpdatePeriod = "sy:updatePeriod"
    case syUpdateFrequency = "sy:updateFrequency"
    case item
    case itunesAuthor = "itunes:author"
    case itunesImage = "itunes:image"
    case itunesOwner = "itunes:owner"
  }
}

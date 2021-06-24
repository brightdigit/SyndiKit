import Foundation
struct RSSItem: Codable {
  let title: String
  let link: URL
  let description: String
  let guid: RSSGUID
  let pubDate: Date?
  let contentEncoded: String?
  let itunesTitle: String?
  let itunesEpisode: String?
  let itunesAuthor: String?
  let itunesSubtitle: String?
  let itunesSummary: String?
  let itunesExplicit: String?
  let itunesDuration: String?
  let itunesImage: iTunesImage?

  enum CodingKeys: String, CodingKey {
    case title
    case link
    case description
    case guid
    case pubDate
    case contentEncoded = "content:encoded"
    case itunesTitle = "itunes:title"
    case itunesEpisode = "itunes:episode"
    case itunesAuthor = "itunes:author"
    case itunesSubtitle = "itunes:subtitle"
    case itunesSummary = "itunes:summary"
    case itunesExplicit = "itunes:explicit"
    case itunesDuration = "itunes:duration"
    case itunesImage = "itunes:image"
  }
}

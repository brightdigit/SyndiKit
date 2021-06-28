import Foundation
import XMLCoder

struct RSSItem: Codable {
  let title: String
  let link: URL
  let description: CData
  let guid: RSSGUID
  let pubDate: Date?
  let contentEncoded: CData?
  let categoryTerms: [CData]
  let content: String?
  let itunesTitle: String?
  let itunesEpisode: iTunesEpisode?
  let itunesAuthor: String?
  let itunesSubtitle: String?
  let itunesSummary: String?
  let itunesExplicit: String?
  let itunesDuration: iTunesDuration?
  let itunesImage: iTunesImage?
  let enclosure: Enclosure?
  let creator: String?

  enum CodingKeys: String, CodingKey {
    case title
    case link
    case description
    case guid
    case pubDate
    case categoryTerms = "category"
    case enclosure
    case contentEncoded = "content:encoded"
    case content
    case itunesTitle = "itunes:title"
    case itunesEpisode = "itunes:episode"
    case itunesAuthor = "itunes:author"
    case itunesSubtitle = "itunes:subtitle"
    case itunesSummary = "itunes:summary"
    case itunesExplicit = "itunes:explicit"
    case itunesDuration = "itunes:duration"
    case itunesImage = "itunes:image"
    case creator = "dc:creator"
  }
}

extension RSSItem: Entryable {
  var categories: [Category] {
    return categoryTerms
  }

  var url: URL {
    return link
  }

  var contentHtml: String? {
    return contentEncoded?.value ?? content ?? description.value
  }

  var summary: String? {
    return description.value
  }

  var datePublished: Date? {
    return pubDate
  }

  var author: RSSAuthor? {
    return nil
  }

  var id: RSSGUID {
    return guid
  }

  var published: Date? {
    return pubDate
  }
}

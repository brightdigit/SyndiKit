import DeveloperToolsSupport
import Foundation
import XMLCoder

struct iTunesEpisode: Codable {
  let value: Int

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    value = try container.decode(Int.self)
  }
}

struct RSSItem: Codable {
  let title: String
  let link: URL
  let description: CData
  let guid: RSSGUID
  let pubDate: Date?
  let contentEncoded: CData?
  let category: [CData]
  let content: String?
  let itunesTitle: String?
  #warning("special type")
  let itunesEpisode: iTunesEpisode?
  #warning("special type of episodeType")
  let itunesAuthor: String?
  let itunesSubtitle: String?
  let itunesSummary: String?
  let itunesExplicit: String?
  #warning("special type of duration")
  let itunesDuration: String?
  let itunesImage: iTunesImage?

  enum CodingKeys: String, CodingKey {
    case title
    case link
    case description
    case guid
    case pubDate
    case category
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
  }
}

extension String {
  func trimAndNilIfEmpty() -> String? {
    let text = trimmingCharacters(in: .whitespacesAndNewlines)
    return text.isEmpty ? nil : text
  }
}

extension RSSItem: Entryable {
  var url: URL {
    return link
  }

  var contentHtml: String? {
    return contentEncoded?.value.trimAndNilIfEmpty() ?? content?.trimAndNilIfEmpty() ?? description.value.trimAndNilIfEmpty()
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

  var categories: [String] {
    return []
  }
}

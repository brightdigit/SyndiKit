import Foundation
import XMLCoder
struct RSSItemDescription : Codable {
  
  let value : String
  
  enum CodingKeys : String, CodingKey {
    case value = "#CDATA"
  }
  
  init(from decoder: Decoder) throws {
    let value : String
    do {
      let container = try decoder.container(keyedBy: CodingKeys.self) 
      value = try container.decode(String.self, forKey: .value)
    } catch {
    
      let container = try decoder.singleValueContainer()
        value = try container.decode(String.self)
    }
      self.value = value
  }
  
}
struct RSSItem: Codable {
  let title: String
  let link: URL
  let description: RSSItemDescription
  let guid: RSSGUID
  let pubDate: Date?
  let contentEncoded: String?
  let content: String?
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
  func trimAndNilIfEmpty () -> String? {
    let text = self.trimmingCharacters(in: .whitespacesAndNewlines)
    return text.isEmpty ? nil : text
  }
}
extension RSSItem : RSSFeedItem {
  var url: URL {
    return link
  }
  
  var contentHtml: String? {
    return contentEncoded?.trimAndNilIfEmpty() ?? content?.trimAndNilIfEmpty() ?? description.value.trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  var summary: String? {
    return description.value
  }
  
  var datePublished: Date? {
    return pubDate
  }
  
  var rssAuthor: RSSAuthor? {
    return nil
  }
  
  
}

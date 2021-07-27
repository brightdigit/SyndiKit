import Foundation
import XMLCoder

public struct RSSMedia: Codable {
  let url: URL
  let medium: String?
}

public struct RSSItem: Codable {
  public let title: String
  public let link: URL
  public let description: CData
  public let guid: RSSGUID
  public let pubDate: Date?
  public let contentEncoded: CData?
  public let categoryTerms: [CData]
  public let content: String?
  public let itunesTitle: String?
  public let itunesEpisode: iTunesEpisode?
  public let itunesAuthor: String?
  public let itunesSubtitle: String?
  public let itunesSummary: String?
  public let itunesExplicit: String?
  public let itunesDuration: iTunesDuration?
  public let itunesImage: iTunesImage?
  public let enclosure: Enclosure?
  public let creator: String?
  public let mediaContent: RSSMedia?
  public let mediaThumbnail: RSSMedia?

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
    case mediaContent = "media:content"
    case mediaThumbnail = "media:thumbnail"
  }
}

extension RSSItem: Entryable {
  public var categories: [RSSCategory] {
    categoryTerms
  }

  public var url: URL {
    link
  }

  public var contentHtml: String? {
    contentEncoded?.value ?? content ?? description.value
  }

  public var summary: String? {
    description.value
  }

  public var author: RSSAuthor? {
    creator.map(RSSAuthor.init) ?? itunesAuthor.map(RSSAuthor.init)
  }

  public var id: RSSGUID {
    guid
  }

  public var published: Date? {
    pubDate
  }

  public var media: MediaContent? {
    PodcastEpisode(rssItem: self).map(MediaContent.podcast)
  }

  public var imageURL: URL? {
    itunesImage?.href ??
      mediaThumbnail?.url ??
      mediaContent?.url
//    item.iTunes?.iTunesImage?.attributes?.href.flatMap(URL.init(string:)) ??
//              enclosure?.imageURL ??
//              item.media?.mediaThumbnails?.compactMap {
//                $0.attributes?.url.flatMap(URL.init(string:))
//              }.first
  }
}

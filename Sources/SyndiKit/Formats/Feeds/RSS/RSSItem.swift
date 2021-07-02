import Foundation
import XMLCoder

public struct WPPostMeta : Codable {
  let key: CData
  let value: CData
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
  public let wpPostID: Int?
  public let wpPostDate: Date?
  public let wpPostDateGMT: Date?
  public let wpModifiedDate: Date?
  public let wpModifiedDateGMT: Date?
  public let wpPostName: CData?
  public let wpPostType: CData?
  public let wpPostMeta: [WPPostMeta]?
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.title = try container.decode(String.self, forKey: .title)
    self.link = try container.decode(URL.self, forKey: .link)
    self.description = try container.decode(CData.self, forKey: .description)
    self.guid = try container.decode(RSSGUID.self, forKey: .guid)
    let pubDate : Date?
    if let pubDateString = try container.decodeIfPresent(String.self, forKey: .pubDate), !pubDateString.isEmpty {
      pubDate = DateFormatterDecoder.RSS.decoder.decodeString(pubDateString)
    } else {
      pubDate = nil
    }
    
    self.pubDate = pubDate
    self.contentEncoded = try container.decodeIfPresent(CData.self, forKey: .contentEncoded)
    self.categoryTerms = try container.decode([CData].self, forKey: .categoryTerms)
    self.content = try container.decodeIfPresent(String.self, forKey: .content)
    self.itunesTitle = try container.decodeIfPresent(String.self, forKey: .itunesTitle)
    self.itunesEpisode = try container.decodeIfPresent(iTunesEpisode.self, forKey: .itunesEpisode)
    self.itunesAuthor = try container.decodeIfPresent(String.self, forKey: .itunesAuthor)
    self.itunesSubtitle = try container.decodeIfPresent(String.self, forKey: .itunesSubtitle)
    self.itunesSummary = try container.decodeIfPresent(String.self, forKey: .itunesSummary)
    self.itunesExplicit = try container.decodeIfPresent(String.self, forKey: .itunesExplicit)
    self.itunesDuration = try container.decodeIfPresent(iTunesDuration.self, forKey: .itunesDuration)
    self.itunesImage = try container.decodeIfPresent(iTunesImage.self, forKey: .itunesImage)
    self.enclosure = try container.decodeIfPresent(Enclosure.self, forKey: .enclosure)
    self.creator = try container.decodeIfPresent(String.self, forKey: .creator)
    self.wpPostID = try container.decodeIfPresent(Int.self, forKey: .wpPostID)
    self.wpPostDate = try container.decodeIfPresent(Date.self, forKey: .wpPostDate)
    let wpPostDateGMT = try container.decodeIfPresent(String.self, forKey: .wpPostDateGMT)
    if let wpPostDateGMT = wpPostDateGMT  {
      if wpPostDateGMT == "0000-00-00 00:00:00" {
        self.wpPostDateGMT = nil
      } else {
        self.wpPostDateGMT = try container.decode(Date.self, forKey: .wpPostDateGMT)
      }
    } else {
      self.wpPostDateGMT = nil
    }
    
    self.wpModifiedDate = try container.decodeIfPresent(Date.self, forKey: .wpModifiedDate)
    self.wpModifiedDateGMT = try container.decodeIfPresent(Date.self, forKey: .wpModifiedDateGMT)
    self.wpPostName = try container.decodeIfPresent(CData.self, forKey: .wpPostName)
    self.wpPostType = try container.decodeIfPresent(CData.self, forKey: .wpPostType)
    self.wpPostMeta = try container.decodeIfPresent([WPPostMeta].self, forKey: .wpPostMeta)
    
  }
  

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
    case wpPostID = "wp:postId"
    case wpPostDate = "wp:postDate"
    case wpPostDateGMT = "wp:postDateGmt"
    case wpModifiedDate = "wp:modifiedDate"
    case wpModifiedDateGMT = "wp:modifiedDateGmt"
    case wpPostName = "wp:postName"
    case wpPostType = "wp:postType"
    case wpPostMeta = "wp:postMeta"
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
}

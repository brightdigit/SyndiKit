import Foundation
import XMLCoder

extension KeyedDecodingContainerProtocol {
  func decodeDateIfPresentAndValid(forKey key: Key) throws -> Date? {
    if let pubDateString =
      try decodeIfPresent(String.self, forKey: key),
      !pubDateString.isEmpty {
      return DateFormatterDecoder.RSS.decoder.decodeString(pubDateString)
    }
    return nil
  }
}

public struct RSSItem: Codable {
  public let title: String
  public let link: URL
  public let description: CData
  public let guid: RSSGUID
  public let pubDate: Date?
  public let contentEncoded: CData?
  public let categoryTerms: [RSSItemCategory]
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
  public let wpCommentStatus: CData?
  public let wpPingStatus: CData?
  public let wpStatus: CData?
  public let wpPostParent: Int?
  public let wpMenuOrder: Int?
  public let wpIsSticky: Int?
  public let wpPostPassword: CData?
  public let wpPostID: Int?
  public let wpPostDate: Date?
  public let wpPostDateGMT: Date?
  public let wpModifiedDate: Date?
  public let wpModifiedDateGMT: Date?
  public let wpPostName: CData?
  public let wpPostType: CData?
  public let wpPostMeta: [WPPostMeta]?

  // swiftlint:disable:next function_body_length
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decode(String.self, forKey: .title)
    link = try container.decode(URL.self, forKey: .link)
    description = try container.decode(CData.self, forKey: .description)
    guid = try container.decode(RSSGUID.self, forKey: .guid)
    pubDate = try container.decodeDateIfPresentAndValid(forKey: .pubDate)
    contentEncoded = try container.decodeIfPresent(CData.self, forKey: .contentEncoded)
    categoryTerms = try container.decode([RSSItemCategory].self, forKey: .categoryTerms)
    content = try container.decodeIfPresent(String.self, forKey: .content)
    itunesTitle = try container.decodeIfPresent(String.self, forKey: .itunesTitle)
    itunesEpisode = try container.decodeIfPresent(
      iTunesEpisode.self, forKey: .itunesEpisode
    )
    itunesAuthor = try container.decodeIfPresent(String.self, forKey: .itunesAuthor)
    itunesSubtitle = try container.decodeIfPresent(String.self, forKey: .itunesSubtitle)
    itunesSummary = try container.decodeIfPresent(String.self, forKey: .itunesSummary)
    itunesExplicit = try container.decodeIfPresent(String.self, forKey: .itunesExplicit)
    itunesDuration = try container.decodeIfPresent(
      iTunesDuration.self, forKey: .itunesDuration
    )
    itunesImage = try container.decodeIfPresent(iTunesImage.self, forKey: .itunesImage)
    enclosure = try container.decodeIfPresent(Enclosure.self, forKey: .enclosure)
    creator = try container.decodeIfPresent(String.self, forKey: .creator)
    wpPostID = try container.decodeIfPresent(Int.self, forKey: .wpPostID)
    wpPostDate = try container.decodeIfPresent(Date.self, forKey: .wpPostDate)
    let wpPostDateGMT = try container.decodeIfPresent(
      String.self, forKey: .wpPostDateGMT
    )
    if let wpPostDateGMT = wpPostDateGMT {
      if wpPostDateGMT == "0000-00-00 00:00:00" {
        self.wpPostDateGMT = nil
      } else {
        self.wpPostDateGMT = try container.decode(
          Date.self, forKey: .wpPostDateGMT
        )
      }
    } else {
      self.wpPostDateGMT = nil
    }

    wpModifiedDate = try container.decodeIfPresent(
      Date.self, forKey: .wpModifiedDate
    )

    let wpModifiedDateGMT = try container.decodeIfPresent(
      String.self, forKey: .wpModifiedDateGMT
    )
    if let wpModifiedDateGMT = wpModifiedDateGMT {
      if wpModifiedDateGMT == "0000-00-00 00:00:00" {
        self.wpModifiedDateGMT = nil
      } else {
        self.wpModifiedDateGMT = try container.decode(
          Date.self, forKey: .wpModifiedDateGMT
        )
      }
    } else {
      self.wpModifiedDateGMT = nil
    }

    wpPostName = try container.decodeIfPresent(CData.self, forKey: .wpPostName)
    wpPostType = try container.decodeIfPresent(CData.self, forKey: .wpPostType)
    wpPostMeta = try container.decodeIfPresent([WPPostMeta].self, forKey: .wpPostMeta)
    wpCommentStatus = try container.decodeIfPresent(CData.self, forKey: .wpCommentStatus)
    wpPingStatus = try container.decodeIfPresent(CData.self, forKey: .wpPingStatus)
    wpStatus = try container.decodeIfPresent(CData.self, forKey: .wpStatus)
    wpPostParent = try container.decodeIfPresent(Int.self, forKey: .wpPostParent)
    wpMenuOrder = try container.decodeIfPresent(Int.self, forKey: .wpMenuOrder)
    wpIsSticky = try container.decodeIfPresent(Int.self, forKey: .wpIsSticky)
    wpPostPassword = try container.decodeIfPresent(
      CData.self, forKey: .wpPostPassword
    )
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
    case wpModifiedDate = "wp:postModified"
    case wpModifiedDateGMT = "wp:postModifiedGmt"
    case wpPostName = "wp:postName"
    case wpPostType = "wp:postType"
    case wpPostMeta = "wp:postmeta"
    case wpCommentStatus = "wp:commentStatus"
    case wpPingStatus = "wp:pingStatus"

    case wpStatus = "wp:status"
    case wpPostParent = "wp:postParent"
    case wpMenuOrder = "wp:menuOrder"
    case wpIsSticky = "wp:isSticky"
    case wpPostPassword = "wp:postPassword"
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

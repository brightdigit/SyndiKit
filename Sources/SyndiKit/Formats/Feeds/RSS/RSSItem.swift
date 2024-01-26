import Foundation
import XMLCoder

public struct RSSItem: Codable {
  public enum CodingKeys: String, CodingKey {
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
    case podcastPeople = "podcast:person"
    case podcastTranscripts = "podcast:transcript"
    case podcastChapters = "podcast:chapters"
    case podcastSoundbites = "podcast:soundbite"
    case podcastSeason = "podcast:season"
    case itunesDuration = "itunes:duration"
    case itunesImage = "itunes:image"
    case creators = "dc:creator"

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
    case wpAttachmentURL = "wp:attachmentUrl"

    case wpStatus = "wp:status"
    case wpPostParent = "wp:postParent"
    case wpMenuOrder = "wp:menuOrder"
    case wpIsSticky = "wp:isSticky"
    case wpPostPassword = "wp:postPassword"

    case mediaContent = "media:content"
    case mediaThumbnail = "media:thumbnail"
  }

  public let title: String
  public let link: URL?
  public let description: CData?
  public let guid: EntryID
  public let pubDate: Date?
  public let contentEncoded: CData?
  public let categoryTerms: [RSSItemCategory]
  public let content: String?
  public let itunesTitle: String?
  public let itunesEpisode: iTunesEpisode?
  public let itunesAuthor: String?
  public let itunesSubtitle: String?
  public let itunesSummary: CData?
  public let itunesExplicit: String?
  public let itunesDuration: iTunesDuration?
  public let itunesImage: iTunesImage?
  public let podcastPeople: [PodcastPerson]
  public let podcastTranscripts: [PodcastTranscript]
  public let podcastChapters: PodcastChapters?
  public let podcastSoundbites: [PodcastSoundbite]
  public let podcastSeason: PodcastSeason?
  public let enclosure: Enclosure?
  public let creators: [String]
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
  public let wpPostMeta: [WordPressElements.PostMeta]
  public let wpAttachmentURL: URL?
  public let mediaContent: AtomMedia?
  public let mediaThumbnail: AtomMedia?
}

extension RSSItem: Entryable {
  public var categories: [EntryCategory] {
    categoryTerms
  }

  public var url: URL? {
    link
  }

  public var contentHtml: String? {
    contentEncoded?.value ?? content ?? description?.value
  }

  public var summary: String? {
    description?.value
  }

  public var authors: [Author] {
    let authors = creators.map(Author.init)
    guard authors.isEmpty else {
      return authors
    }
    guard let author = itunesAuthor.map(Author.init) else {
      return []
    }
    return [author]
  }

  public var id: EntryID {
    guid
  }

  public var published: Date? {
    pubDate
  }

  public var media: MediaContent? {
    PodcastEpisodeProperties(rssItem: self).map(MediaContent.podcast)
  }

  public var imageURL: URL? {
    itunesImage?.href ??
      mediaThumbnail?.url ??
      mediaContent?.url
  }
}

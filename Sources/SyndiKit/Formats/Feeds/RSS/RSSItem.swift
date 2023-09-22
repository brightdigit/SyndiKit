import Foundation
import XMLCoder

public struct RSSItem: Codable {
  public let title: String
  public let link: URL
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

  // swiftlint:disable:next function_body_length
  public init(
    title: String,
    link: URL,
    description: String?,
    guid: EntryID,
    pubDate: Date? = nil,
    contentEncoded: String? = nil,
    categoryTerms: [RSSItemCategory] = [],
    content: String? = nil,
    itunesTitle: String? = nil,
    itunesEpisode: Int? = nil,
    itunesAuthor: String? = nil,
    itunesSubtitle: String? = nil,
    itunesSummary: CData? = nil,
    itunesExplicit: String? = nil,
    itunesDuration: TimeInterval? = nil,
    itunesImage: iTunesImage? = nil,
    podcastPeople: [PodcastPerson] = [],
    podcastTranscripts: [PodcastTranscript] = [],
    podcastChapters: PodcastChapters? = nil,
    podcastSoundbites: [PodcastSoundbite] = [],
    podcastSeason: PodcastSeason? = nil,
    enclosure: Enclosure? = nil,
    creators: [String] = [],
    wpCommentStatus: String? = nil,
    wpPingStatus: String? = nil,
    wpStatus: String? = nil,
    wpPostParent: Int? = nil,
    wpMenuOrder: Int? = nil,
    wpIsSticky: Int? = nil,
    wpPostPassword: String? = nil,
    wpPostID: Int? = nil,
    wpPostDate: Date? = nil,
    wpPostDateGMT: Date? = nil,
    wpModifiedDate: Date? = nil,
    wpModifiedDateGMT: Date? = nil,
    wpPostName: String? = nil,
    wpPostType: String? = nil,
    wpPostMeta: [WordPressElements.PostMeta] = [],
    wpAttachmentURL: URL? = nil,
    mediaContent: AtomMedia? = nil,
    mediaThumbnail: AtomMedia? = nil
  ) {
    self.title = title
    self.link = link
    self.description = description.map(CData.init)
    self.guid = guid
    self.pubDate = pubDate
    self.contentEncoded = contentEncoded.map(CData.init)
    self.categoryTerms = categoryTerms
    self.content = content
    self.itunesTitle = itunesTitle
    self.itunesEpisode = itunesEpisode.map(iTunesEpisode.init)
    self.itunesAuthor = itunesAuthor
    self.itunesSubtitle = itunesSubtitle
    self.itunesSummary = itunesSummary
    self.itunesExplicit = itunesExplicit
    self.itunesDuration = itunesDuration.map(iTunesDuration.init)
    self.itunesImage = itunesImage
    self.podcastPeople = podcastPeople
    self.podcastTranscripts = podcastTranscripts
    self.podcastChapters = podcastChapters
    self.podcastSoundbites = podcastSoundbites
    self.podcastSeason = podcastSeason
    self.enclosure = enclosure
    self.creators = creators
    self.wpCommentStatus = wpCommentStatus.map(CData.init)
    self.wpPingStatus = wpPingStatus.map(CData.init)
    self.wpStatus = wpStatus.map(CData.init)
    self.wpPostParent = wpPostParent
    self.wpMenuOrder = wpMenuOrder
    self.wpIsSticky = wpIsSticky
    self.wpPostPassword = wpPostPassword.map(CData.init)
    self.wpPostID = wpPostID
    self.wpPostDate = wpPostDate
    self.wpPostDateGMT = wpPostDateGMT
    self.wpModifiedDate = wpModifiedDate
    self.wpModifiedDateGMT = wpModifiedDateGMT
    self.wpPostName = wpPostName.map(CData.init)
    self.wpPostType = wpPostType.map(CData.init)
    self.wpPostMeta = wpPostMeta
    self.wpAttachmentURL = wpAttachmentURL
    self.mediaContent = mediaContent
    self.mediaThumbnail = mediaThumbnail
  }

  // swiftlint:disable:next function_body_length
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decode(String.self, forKey: .title)
    link = try container.decode(URL.self, forKey: .link)
    description = try container.decodeIfPresent(CData.self, forKey: .description)
    guid = try container.decode(EntryID.self, forKey: .guid)
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
    itunesSummary = try container.decodeIfPresent(CData.self, forKey: .itunesSummary)
    itunesExplicit = try container.decodeIfPresent(String.self, forKey: .itunesExplicit)
    itunesDuration = try container.decodeIfPresent(
      iTunesDuration.self, forKey: .itunesDuration
    )
    itunesImage = try container.decodeIfPresent(iTunesImage.self, forKey: .itunesImage)

    podcastPeople = try container.decodeIfPresent(
      [PodcastPerson].self,
      forKey: .podcastPeople
    ) ?? []
    podcastTranscripts = try container.decodeIfPresent(
      [PodcastTranscript].self,
      forKey: .podcastTranscripts
    ) ?? []
    podcastChapters = try container.decodeIfPresent(
      PodcastChapters.self,
      forKey: .podcastChapters
    )
    podcastSoundbites = try container.decodeIfPresent(
      [PodcastSoundbite].self,
      forKey: .podcastSoundbites
    ) ?? []

    podcastSeason = try container.decodeIfPresent(
      PodcastSeason.self,
      forKey: .podcastSeason
    )

    enclosure = try container.decodeIfPresent(Enclosure.self, forKey: .enclosure)
    creators = try container.decode([String].self, forKey: .creators)

    mediaContent =
      try container.decodeIfPresent(AtomMedia.self, forKey: .mediaContent)
    mediaThumbnail =
      try container.decodeIfPresent(AtomMedia.self, forKey: .mediaThumbnail)

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

    let wpAttachmentURLCDData = try container.decodeIfPresent(
      CData.self,
      forKey: .wpAttachmentURL
    )
    wpAttachmentURL = wpAttachmentURLCDData.map { $0.value }.flatMap(URL.init(string:))

    wpPostName = try container.decodeIfPresent(CData.self, forKey: .wpPostName)
    wpPostType = try container.decodeIfPresent(CData.self, forKey: .wpPostType)
    wpPostMeta = try container.decodeIfPresent(
      [WordPressElements.PostMeta].self,
      forKey: .wpPostMeta
    ) ?? []
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
}

extension RSSItem: Entryable {
  public var categories: [EntryCategory] {
    categoryTerms
  }

  public var url: URL {
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

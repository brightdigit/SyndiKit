import Foundation
import XMLCoder

extension RSSItem {
  // swiftlint:disable function_body_length
  /**
   Initializes a new `RSSItem` instance.

   - Parameters:
     - title: The title of the RSS item.
     - link: The URL link of the RSS item.
     - description: The description of the RSS item.
     - guid: The globally unique identifier of the RSS item.
     - pubDate: The publication date of the RSS item.
     - contentEncoded: The encoded content of the RSS item.
     - categoryTerms: The category terms of the RSS item.
     - content: The content of the RSS item.
     - itunesTitle: The iTunes title of the RSS item.
     - itunesEpisode: The iTunes episode of the RSS item.
     - itunesAuthor: The iTunes author of the RSS item.
     - itunesSubtitle: The iTunes subtitle of the RSS item.
     - itunesSummary: The iTunes summary of the RSS item.
     - itunesExplicit: The iTunes explicit flag of the RSS item.
     - itunesDuration: The iTunes duration of the RSS item.
     - itunesImage: The iTunes image of the RSS item.
     - podcastPeople: The podcast people of the RSS item.
     - podcastTranscripts: The podcast transcripts of the RSS item.
     - podcastChapters: The podcast chapters of the RSS item.
     - podcastSoundbites: The podcast soundbites of the RSS item.
     - podcastSeason: The podcast season of the RSS item.
     - enclosure: The enclosure of the RSS item.
     - creators: The creators of the RSS item.
     - wpCommentStatus: The WordPress comment status of the RSS item.
     - wpPingStatus: The WordPress ping status of the RSS item.
     - wpStatus: The WordPress status of the RSS item.
     - wpPostParent: The WordPress post parent of the RSS item.
     - wpMenuOrder: The WordPress menu order of the RSS item.
     - wpIsSticky: The WordPress sticky flag of the RSS item.
     - wpPostPassword: The WordPress post password of the RSS item.
     - wpPostID: The WordPress post ID of the RSS item.
     - wpPostDate: The WordPress post date of the RSS item.
     - wpPostDateGMT: The WordPress post date in GMT of the RSS item.
     - wpModifiedDate: The WordPress modified date of the RSS item.
     - wpModifiedDateGMT: The WordPress modified date in GMT of the RSS item.
     - wpPostName: The WordPress post name of the RSS item.
     - wpPostType: The WordPress post type of the RSS item.
     - wpPostMeta: The WordPress post meta of the RSS item.
     - wpAttachmentURL: The WordPress attachment URL of the RSS item.
     - mediaContent: The media content of the RSS item.
     - mediaThumbnail: The media thumbnail of the RSS item.
   */
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

  // swiftlint:enable function_body_length
}

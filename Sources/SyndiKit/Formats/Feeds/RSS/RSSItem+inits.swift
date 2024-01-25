import Foundation
import XMLCoder

extension RSSItem {
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
}

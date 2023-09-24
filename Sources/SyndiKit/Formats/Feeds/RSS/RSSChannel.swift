import Foundation

/// information about the channel (metadata) and its contents.
public struct RSSChannel: Codable {
  /// The name of the channel.
  public let title: String

  /// The URL to the HTML website corresponding to the channel.
  public let link: URL

  /// Phrase or sentence describing the channel.
  public let description: String?

  /// The last time the content of the channel changed.
  public let lastBuildDate: Date?

  /// indicates the publication date and time of the feed's content
  public let pubDate: Date?

  /// ttl stands for time to live.
  /// It's a number of minutes
  /// that indicates how long a channel can be cached
  /// before refreshing from the source.
  public let ttl: Int?
  /// Describes the period over which the channel format is updated.
  public let syUpdatePeriod: SyndicationUpdatePeriod?
  /// Used to describe the frequency of updates
  /// in relation to the update period.
  /// A positive integer indicates
  /// how many times in that period the channel is updated.
  public let syUpdateFrequency: SyndicationUpdateFrequency?
  public let items: [RSSItem]
  public let itunesAuthor: String?
  public let itunesImage: String?
  public let itunesOwner: iTunesOwner?

  /// Copyright notice for content in the channel.
  public let copyright: String?

  /// Specifies a GIF, JPEG or PNG image that can be displayed with the channel.
  public let image: RSSImage?
  public let author: Author?
  public let wpCategories: [WordPressElements.Category]
  public let wpTags: [WordPressElements.Tag]
  public let wpBaseSiteURL: URL?
  public let wpBaseBlogURL: URL?

  public let podcastLocked: PodcastLocked?
  public let podcastFundings: [PodcastFunding]
  public let podcastPeople: [PodcastPerson]

  enum CodingKeys: String, CodingKey {
    case title
    case link
    case description
    case lastBuildDate
    case pubDate
    case ttl
    case syUpdatePeriod = "sy:updatePeriod"
    case syUpdateFrequency = "sy:updateFrequency"
    case items = "item"
    case itunesAuthor = "itunes:author"
    case itunesImage = "itunes:image"
    case itunesOwner = "itunes:owner"
    case copyright
    case image
    case author
    case wpCategories = "wp:category"
    case wpTags = "wp:tag"
    case wpBaseSiteURL = "wp:baseSiteUrl"
    case wpBaseBlogURL = "wp:baseBlogUrl"
    case podcastLocked = "podcast:locked"
    case podcastFundings = "podcast:funding"
    case podcastPeople = "podcast:person"
  }
}

public extension RSSChannel {
  var syndication: SyndicationUpdate? {
    SyndicationUpdate(
      period: syUpdatePeriod,
      frequency: syUpdateFrequency?.value
    )
  }
}

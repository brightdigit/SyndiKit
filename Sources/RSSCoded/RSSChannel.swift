import Foundation

public struct RSSChannel: Codable {
  public let title: String
  public let link: URL
  public let description: String?
  public let lastBuildDate: Date?
  public let pubDate: Date?
  public let syUpdatePeriod: SyndicationUpdatePeriod?
  public let syUpdateFrequency: SyndicationUpdateFrequency?
  public let item: [RSSItem]
  public let itunesAuthor: String?
  public let itunesImage: String?
  public let itunesOwner: iTunesOwner?
  public let copyright: String?
  public let image: RSSImage?
  public let author: RSSAuthor?

  enum CodingKeys: String, CodingKey {
    case title
    case link
    case description
    case lastBuildDate
    case pubDate
    case syUpdatePeriod = "sy:updatePeriod"
    case syUpdateFrequency = "sy:updateFrequency"
    case item
    case itunesAuthor = "itunes:author"
    case itunesImage = "itunes:image"
    case itunesOwner = "itunes:owner"
    case copyright
    case image
    case author
  }
}

public extension RSSChannel {
  var syndication: SyndicationUpdate? {
    return SyndicationUpdate(period: syUpdatePeriod, frequency: syUpdateFrequency?.value)
  }
}

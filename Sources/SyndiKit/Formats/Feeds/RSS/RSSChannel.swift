import Foundation

public struct WPCategory: Codable {
  let termID: Int
  let niceName: CData
  let parent: CData
  let name: String

  enum CodingKeys: String, CodingKey {
    case termID = "wp:termId"
    case niceName = "wp:categoryNicename"
    case parent = "wp:categoryParent"
    case name = "wp:catName"
  }
}

public struct WPTag: Codable {
  let termID: Int
  let slug: CData
  let name: CData

  enum CodingKeys: String, CodingKey {
    case termID = "wp:termId"
    case slug = "wp:tagSlug"
    case name = "wp:tagName"
  }
}

public struct RSSChannel: Codable {
  public let title: String
  public let link: URL
  public let description: String?
  public let lastBuildDate: Date?
  public let pubDate: Date?
  public let syUpdatePeriod: SyndicationUpdatePeriod?
  public let syUpdateFrequency: SyndicationUpdateFrequency?
  public let items: [RSSItem]
  public let itunesAuthor: String?
  public let itunesImage: String?
  public let itunesOwner: iTunesOwner?
  public let copyright: String?
  public let image: RSSImage?
  public let author: RSSAuthor?
  public let wpCategories: [WPCategory]
  public let wpTags: [WPTag]

  enum CodingKeys: String, CodingKey {
    case title
    case link
    case description
    case lastBuildDate
    case pubDate
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
  }
}

public extension RSSChannel {
  var syndication: SyndicationUpdate? {
    SyndicationUpdate(period: syUpdatePeriod, frequency: syUpdateFrequency?.value)
  }
}

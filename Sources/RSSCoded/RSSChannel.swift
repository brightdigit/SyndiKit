import Foundation

struct RSSChannel: Codable {
  let title: String
  let link: URL
  let description: String?
  let lastBuildDate: Date?
  let pubDate: Date?
  let syUpdatePeriod: SyndicationUpdatePeriod?
  let syUpdateFrequency: SyndicationUpdateFrequency?
  let item: [RSSItem]
  let itunesAuthor: String?
  let itunesImage: String?
  let itunesOwner: iTunesOwner?
  let copyright: String?
  let image: RSSImage?

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
  }
}

extension RSSChannel {
  var syndication: SyndicationUpdate? {
    return SyndicationUpdate(period: syUpdatePeriod, frequency: syUpdateFrequency?.value)
  }
}

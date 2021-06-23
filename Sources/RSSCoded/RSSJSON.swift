import Foundation

struct RSSItem: Codable {
  let title: String
  let link: URL
  let description: String
  let guid: RSSGUID
  let pubDate: Date?
  let contentEncoded: String?
  let itunesTitle: String?
  let itunesEpisode: String?
  let itunesAuthor: String?
  let itunesSubtitle: String?
  let itunesSummary: String?
  let itunesExplicit: String?
  let itunesDuration: String?
  let itunesImage: iTunesImage?

  enum CodingKeys: String, CodingKey {
    case title
    case link
    case description
    case guid
    case pubDate
    case contentEncoded = "content:encoded"
    case itunesTitle = "itunes:title"
    case itunesEpisode = "itunes:episode"
    case itunesAuthor = "itunes:author"
    case itunesSubtitle = "itunes:subtitle"
    case itunesSummary = "itunes:summary"
    case itunesExplicit = "itunes:explicit"
    case itunesDuration = "itunes:duration"
    case itunesImage = "itunes:image"
  }
}

struct RSSAuthor: Codable {
  let name: String
}

// swiftlint:disable:next type_name
struct iTunesOwner: Codable {
  let name: String
  let email: String

  enum CodingKeys: String, CodingKey {
    case name = "itunes:name"
    case email = "itunes:email"
  }
}

struct RSSChannel: Codable {
  let title: String
  let link: URL
  let description: String?
  let lastBuildDate: Date?
  let syUpdatePeriod: String?
  let syUpdateFrequency: Int?
  let item: [RSSItem]
  let itunesAuthor: String?
  let itunesImage: String?
  let itunesOwner: iTunesOwner?
  enum CodingKeys: String, CodingKey {
    case title
    case link
    case description
    case lastBuildDate
    case syUpdatePeriod = "sy:updatePeriod"
    case syUpdateFrequency = "sy:updateFrequency"
    case item
    case itunesAuthor = "itunes:author"
    case itunesImage = "itunes:image"
    case itunesOwner = "itunes:owner"
  }
}

struct RSS: Codable {
  let channel: RSSChannel
}

// swiftlint:disable:next type_name
typealias iTunesImage = FeedLink
struct FeedLink: Codable {
  let href: URL
}

struct FeedEntry: Codable {
  let id: String
  let title: String
  let published: Date
  let updated: Date
  let link: FeedLink
  let author: RSSAuthor
  let ytVideoID: String?
  let mediaDescription: String?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case published
    case updated
    case link
    case author
    case ytVideoID = "yt:videoId"
    case mediaDescription = "media:description"
  }
}

enum RSSFeed {
  case rss(RSS)
  case feed(Feed)
}

struct Feed: Codable {
  let id: String
  let title: String
  let published: Date?
  let pubDate: Date?
  let link: FeedLink
  let entry: [FeedEntry]
  let author: RSSAuthor
  let ytChannelID: String?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case published
    case pubDate
    case link
    case entry
    case author
    case ytChannelID = "yt:channelId"
  }
}

struct RSSJSON: Codable {
  let version: URL
  let title: String
  let homePageUrl: URL
  let description: String?
  let author: RSSAuthor?
  let items: [RSSJSONItem]
}

enum RSSGUID: Codable {
  case url(URL)
  case uuid(UUID)
  case path([String])
  case string(String)

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let string = try container.decode(String.self)
    if let url = URL(string: string) {
      self = .url(url)
    } else if let uuid = UUID(uuidString: string) {
      self = .uuid(uuid)
    } else {
      let components = string.components(separatedBy: ":")
      if components.count > 1 {
        self = .path(components)
      } else {
        self = .string(string)
      }
    }
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    let string: String
    switch self {
    case let .url(url):
      string = url.absoluteString
    case let .uuid(uuid):
      string = uuid.uuidString.lowercased()
    case let .path(components):
      string = components.joined(separator: ":")
    case let .string(value):
      string = value
    }
    try container.encode(string)
  }
}

struct RSSJSONItem: Codable {
  let guid: RSSGUID
  let url: URL
  let title: String
  let contentHtml: String?
  let summary: String?
  let datePublished: Date?
  let author: RSSAuthor?
}

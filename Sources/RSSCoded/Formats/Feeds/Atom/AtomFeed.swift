import Foundation
public struct AtomFeed {
  public let id: String
  public let title: String
  public let description: String?
  public let subtitle: String?
  public let published: Date?
  public let pubDate: Date?
  public let links: [Link]
  public let entries: [AtomEntry]
  public let author: RSSAuthor?
  public let youtubeChannelID: String?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case description
    case subtitle
    case published
    case pubDate
    case links = "link"
    case entries = "entry"
    case author
    case youtubeChannelID = "yt:channelId"
  }
}

extension AtomFeed: DecodableFeed {
  public var summary: String? {
    description ?? subtitle
  }

  public var children: [Entryable] {
    entries
  }

  public var siteURL: URL? {
    links.first { $0.rel != "self" }?.href
  }

  public var updated: Date? {
    pubDate ?? published
  }

  public var copyright: String? {
    nil
  }

  public var image: URL? {
    nil
  }

  public var syndication: SyndicationUpdate? {
    nil
  }
}

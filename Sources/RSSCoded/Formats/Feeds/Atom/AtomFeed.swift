import Foundation
public struct AtomFeed: Codable {
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

extension AtomFeed: Feedable {
  public var summary: String? {
    return description ?? subtitle
  }

  public var children: [Entryable] {
    return entries
  }

  public var siteURL: URL? {
    links.first { $0.rel != "self" }?.href
  }

  public var updated: Date? {
    return pubDate ?? published
  }

  public var copyright: String? {
    return nil
  }

  public var image: URL? {
    return nil
  }

  public var syndication: SyndicationUpdate? {
    return nil
  }
}

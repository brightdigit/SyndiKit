import Foundation
struct AtomFeed: Codable {
  let id: String
  let title: String
  let description: String?
  let subtitle: String?
  let published: Date?
  let pubDate: Date?
  let links: [Link]
  let entries: [AtomEntry]
  let author: RSSAuthor?
  let youtubeChannelID: String?

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
  var summary: String? {
    return description ?? subtitle
  }

  var feedItems: [Entryable] {
    return entries
  }

  var siteURL: URL? {
    links.first { $0.rel != "self" }?.href
  }

  var updated: Date? {
    return pubDate ?? published
  }

  var copyright: String? {
    return nil
  }

  var image: URL? {
    return nil
  }

  var syndication: SyndicationUpdate? {
    return nil
  }
}

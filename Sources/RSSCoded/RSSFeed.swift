import Foundation
public struct RSSFeed: Codable {
  public let channel: RSSChannel
}

extension RSSFeed: Feedable {
  public var youtubeChannelID: String? {
    return nil
  }

  public var author: RSSAuthor? {
    return channel.author
  }

  public var children: [Entryable] {
    return channel.item
  }

  public var title: String {
    return channel.title
  }

  public var siteURL: URL? {
    return channel.link
  }

  public var summary: String? {
    return channel.description
  }

  public var updated: Date? {
    return channel.lastBuildDate
  }

  public var copyright: String? {
    return channel.copyright
  }

  public var image: URL? {
    return channel.image?.link
  }

  public var syndication: SyndicationUpdate? {
    return channel.syndication
  }
}

import Foundation
public struct RSSFeed {
  public let channel: RSSChannel
}

extension RSSFeed: DecodableFeed {
  public var youtubeChannelID: String? {
    nil
  }

  public var author: RSSAuthor? {
    channel.author
  }

  public var children: [Entryable] {
    channel.items
  }

  public var title: String {
    channel.title
  }

  public var siteURL: URL? {
    channel.link
  }

  public var summary: String? {
    channel.description
  }

  public var updated: Date? {
    channel.lastBuildDate
  }

  public var copyright: String? {
    channel.copyright
  }

  public var image: URL? {
    channel.image?.link
  }

  public var syndication: SyndicationUpdate? {
    channel.syndication
  }

  static let source: DecoderSetup = DecoderSource.xml
}

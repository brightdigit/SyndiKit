import Foundation

/// RSS is a Web content syndication format.
///
/// Its name is an acronym for Really Simple Syndication.
/// RSS is dialect of XML. All RSS files must conform to the XML 1.0 specification, as published on the World Wide Web Consortium (W3C) website.
/// At the top level, a RSS document is a <rss> element, with a mandatory attribute called version, that specifies the version of RSS that the document conforms to. If it conforms to this specification, the version attribute must be 2.0.
/// For more details, check out the [W3 sepcifications.](https://validator.w3.org/feed/docs/rss2.html)
public struct RSSFeed {
  public let channel: RSSChannel
}

extension RSSFeed: DecodableFeed {
  public var youtubeChannelID: String? {
    nil
  }

  public var authors: [Author] {
    guard let author = channel.author else {
      return []
    }
    return [author]
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

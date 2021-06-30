import Foundation

public struct JSONFeed: Codable {
  public let version: URL
  public let title: String
  public let homePageUrl: URL
  public let description: String?
  public let author: RSSAuthor?
  public let items: [JSONItem]
}

extension JSONFeed: Feedable {
  public var youtubeChannelID: String? {
    nil
  }

  public var children: [Entryable] {
    items
  }

  public var summary: String? {
    description
  }

  public var siteURL: URL? {
    homePageUrl
  }

  public var updated: Date? {
    nil
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

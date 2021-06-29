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
    return nil
  }

  public var children: [Entryable] {
    return items
  }

  public var summary: String? {
    return description
  }

  public var siteURL: URL? {
    return homePageUrl
  }

  public var updated: Date? {
    return nil
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

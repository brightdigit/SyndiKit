import Foundation

public struct JSONItem: Codable {
  public let guid: RSSGUID
  public let url: URL
  public let title: String
  public let contentHtml: String?
  public let summary: String?
  public let datePublished: Date?
  public let author: RSSAuthor?
}

extension JSONItem: Entryable {
  public var creator: String? {
    return nil
  }

  public var published: Date? {
    return datePublished
  }

  public var id: RSSGUID {
    return guid
  }

  public var categories: [RSSCategory] {
    return []
  }

  public var media: MediaContent? {
    return nil
  }
}

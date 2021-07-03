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
  public var imageURL: URL? {
    nil
  }

  public var creator: String? {
    nil
  }

  public var published: Date? {
    datePublished
  }

  public var id: RSSGUID {
    guid
  }

  public var categories: [RSSCategory] {
    []
  }

  public var media: MediaContent? {
    nil
  }
}

import Foundation

public struct JSONItem: Codable {
  public let guid: EntryID
  public let url: URL
  public let title: String
  public let contentHtml: String?
  public let summary: String?
  public let datePublished: Date?

  /// The author of the item.
  public let author: Author?
}

extension JSONItem: Entryable {
  public var authors: [Author] {
    guard let author = author else {
      return []
    }
    return [author]
  }

  public var imageURL: URL? {
    nil
  }

  public var creators: [String] {
    []
  }

  public var published: Date? {
    datePublished
  }

  public var id: EntryID {
    guid
  }

  public var categories: [EntryCategory] {
    []
  }

  public var media: MediaContent? {
    nil
  }
}

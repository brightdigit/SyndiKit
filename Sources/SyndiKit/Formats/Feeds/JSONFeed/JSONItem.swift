#if swift(>=5.7)
  @preconcurrency import Foundation
#else
  import Foundation
#endif

/// A struct representing an Atom category.
/// A struct representing an item in JSON format.
/// - SeeAlso: ``EntryCategory``
public struct JSONItem: Codable, Sendable {
  /// The unique identifier of the item.
  public let guid: EntryID

  /// The URL associated with the item.
  public let url: URL?

  /// The title of the item.
  public let title: String

  /// The HTML content of the item.
  public let contentHtml: String?

  /// A summary of the item.
  public let summary: String?

  /// The date the item was published.
  public let datePublished: Date?

  /// The author of the item.
  public let author: Author?
}

extension JSONItem: Entryable {
  /// A struct representing an Atom category.
  ///   Returns an array of authors for the item.
  /// - SeeAlso: ``EntryCategory``
  public var authors: [Author] {
    guard let author = author else {
      return []
    }
    return [author]
  }

  /// The URL of the item's image.
  public var imageURL: URL? {
    nil
  }

  /// A struct representing an Atom category.
  ///   An array of creators associated with the item.
  /// - SeeAlso: ``EntryCategory``
  public var creators: [String] {
    []
  }

  /// The date the item was published.
  public var published: Date? {
    datePublished
  }

  /// The unique identifier of the item.
  public var id: EntryID {
    guid
  }

  /// A struct representing an Atom category.
  ///   An array of categories associated with the item.
  /// - SeeAlso: ``EntryCategory``
  public var categories: [EntryCategory] {
    []
  }

  /// The media content associated with the item.
  public var media: MediaContent? {
    nil
  }
}

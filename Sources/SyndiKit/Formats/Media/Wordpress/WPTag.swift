import Foundation

/// A typealias for `WordPressElements.Tag`
public typealias WPTag = WordPressElements.Tag

// swiftlint:disable nesting
extension WordPressElements {
  /// A struct representing a tag in WordPress.
  public struct Tag: Codable {
    /// The term ID of the tag.
    internal enum CodingKeys: String, CodingKey {
      case termID = "wp:termId"
      case slug = "wp:tagSlug"
      case name = "wp:tagName"
    }

    /// The term ID of the tag.
    public let termID: Int

    /// The slug of the tag.
    public let slug: CData

    /// The name of the tag.
    public let name: CData

    /// A struct representing an Atom category.
    ///     Initializes a new ``Tag`` instance.
    ///
    ///     - Parameters:
    ///       - termID: The term ID of the tag.
    ///       - slug: The slug of the tag.
    ///       - name: The name of the tag.
    /// - SeeAlso: ``EntryCategory``
    public init(termID: Int, slug: CData, name: CData) {
      self.termID = termID
      self.slug = slug
      self.name = name
    }
  }
}

extension WordPressElements.Tag: Equatable {
  /// Checks if two ``Tag`` instances are equal.
  public static func == (lhs: WordPressElements.Tag, rhs: WordPressElements.Tag) -> Bool {
    lhs.termID == rhs.termID
      && lhs.slug == rhs.slug
      && lhs.name == rhs.name
  }
}

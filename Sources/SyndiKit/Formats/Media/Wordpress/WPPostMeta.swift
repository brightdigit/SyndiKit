import Foundation

/// A typealias for `WordPressElements.Category`.
public typealias WPPostMeta = WordPressElements.Category

// swiftlint:disable nesting
extension WordPressElements {
  /// A struct representing metadata for a WordPress post.
  public struct PostMeta: Codable {
    /// The coding keys for encoding and decoding.
    internal enum CodingKeys: String, CodingKey {
      case key = "wp:metaKey"
      case value = "wp:metaValue"
    }

    /// The key of the metadata.
    public let key: CData

    /// The value of the metadata.
    public let value: CData

    /// A struct representing an Atom category.
    ///     Initializes a new `PostMeta` instance.
    ///
    ///     - Parameters:
    ///       - key: The key of the metadata.
    ///       - value: The value of the metadata.
    /// - SeeAlso: `EntryCategory`
    public init(key: String, value: String) {
      self.key = .init(stringLiteral: key)
      self.value = .init(stringLiteral: value)
    }
  }
}

extension WordPressElements.PostMeta: Equatable {
  /// A struct representing an Atom category.
  ///   Checks if two `PostMeta` instances are equal.
  ///
  ///   - Parameters:
  ///     - lhs: The left-hand side `PostMeta` instance.
  ///     - rhs: The right-hand side `PostMeta` instance.
  ///
  ///   - Returns: `true` if the two instances are equal, `false` otherwise.
  /// - SeeAlso: `EntryCategory`
  public static func == (
    lhs: WordPressElements.PostMeta,
    rhs: WordPressElements.PostMeta
  ) -> Bool {
    lhs.key == rhs.key
      && lhs.value == rhs.value
  }
}

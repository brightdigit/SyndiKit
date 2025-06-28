import Foundation

/// A typealias for the `WordPressElements.Category` type.
public typealias WPCategory = WordPressElements.Category

// swiftlint:disable nesting
extension WordPressElements {
  /// A struct representing a category in WordPress.
  public struct Category: Codable, Sendable {
    /// The coding keys for the ``Category`` struct.
    internal enum CodingKeys: String, CodingKey {
      case termID = "wp:termId"
      case niceName = "wp:categoryNicename"
      case parent = "wp:categoryParent"
      case name = "wp:catName"
    }

    /// The unique identifier of the category.
    public let termID: Int

    /// The nice name of the category.
    public let niceName: CData

    /// The parent category of the category.
    public let parent: CData

    /// The name of the category.
    public let name: String

    /// A struct representing an Atom category.
    ///     Initializes a new ``Category`` instance.
    ///
    ///     - Parameters:
    ///       - termID: The unique identifier of the category.
    ///       - niceName: The nice name of the category.
    ///       - parent: The parent category of the category.
    ///       - name: The name of the category.
    /// - SeeAlso: ``EntryCategory``
    public init(termID: Int, niceName: CData, parent: CData, name: String) {
      self.termID = termID
      self.niceName = niceName
      self.parent = parent
      self.name = name
    }
  }
}

extension WordPressElements.Category: Equatable {
  /// Checks if two ``Category`` instances are equal.
  public static func == (
    lhs: WordPressElements.Category,
    rhs: WordPressElements.Category
  ) -> Bool {
    lhs.termID == rhs.termID
      && lhs.niceName == rhs.niceName
      && lhs.parent == rhs.parent
      && lhs.name == rhs.name
  }
}

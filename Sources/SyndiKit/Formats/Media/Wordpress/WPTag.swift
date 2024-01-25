import Foundation

public typealias WPTag = WordPressElements.Tag

// swiftlint:disable nesting
extension WordPressElements {
  public struct Tag: Codable {
    internal enum CodingKeys: String, CodingKey {
      case termID = "wp:termId"
      case slug = "wp:tagSlug"
      case name = "wp:tagName"
    }

    public let termID: Int
    public let slug: CData
    public let name: CData

    public init(termID: Int, slug: CData, name: CData) {
      self.termID = termID
      self.slug = slug
      self.name = name
    }
  }
}

extension WordPressElements.Tag: Equatable {
  public static func == (lhs: WordPressElements.Tag, rhs: WordPressElements.Tag) -> Bool {
    lhs.termID == rhs.termID
      && lhs.slug == rhs.slug
      && lhs.name == rhs.name
  }
}

import Foundation

public extension WordPressElements {
  struct Tag: Codable {
    public let termID: Int
    public let slug: CData
    public let name: CData

    enum CodingKeys: String, CodingKey {
      case termID = "wp:termId"
      case slug = "wp:tagSlug"
      case name = "wp:tagName"
    }

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

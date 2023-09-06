import Foundation

public extension WordPressElements {
  struct Category: Codable {
    public let termID: Int
    public let niceName: CData
    public let parent: CData
    public let name: String

    enum CodingKeys: String, CodingKey {
      case termID = "wp:termId"
      case niceName = "wp:categoryNicename"
      case parent = "wp:categoryParent"
      case name = "wp:catName"
    }
  }
}

extension WordPressElements.Category: Equatable {
  public static func == (lhs: WordPressElements.Category, rhs: WordPressElements.Category) -> Bool {
    lhs.termID == rhs.termID
    && lhs.niceName == rhs.niceName
    && lhs.parent == rhs.parent
    && lhs.name == rhs.name
  }
}

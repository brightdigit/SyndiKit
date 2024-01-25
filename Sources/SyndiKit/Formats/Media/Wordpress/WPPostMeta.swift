import Foundation

public typealias WPPostMeta = WordPressElements.Category

// swiftlint:disable nesting
extension WordPressElements {
  public struct PostMeta: Codable {
    internal enum CodingKeys: String, CodingKey {
      case key = "wp:metaKey"
      case value = "wp:metaValue"
    }

    public let key: CData
    public let value: CData

    public init(key: String, value: String) {
      self.key = .init(stringLiteral: key)
      self.value = .init(stringLiteral: value)
    }
  }
}

extension WordPressElements.PostMeta: Equatable {
  public static func == (
    lhs: WordPressElements.PostMeta,
    rhs: WordPressElements.PostMeta
  ) -> Bool {
    lhs.key == rhs.key
      && lhs.value == rhs.value
  }
}

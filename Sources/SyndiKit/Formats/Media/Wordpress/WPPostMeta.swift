import Foundation

public extension WordPressElements {
  struct PostMeta: Codable {
    public init(key: String, value: String) {
      self.key = .init(stringLiteral: key)
      self.value = .init(stringLiteral: value)
    }

    public let key: CData
    public let value: CData

    enum CodingKeys: String, CodingKey {
      case key = "wp:metaKey"
      case value = "wp:metaValue"
    }
  }
}

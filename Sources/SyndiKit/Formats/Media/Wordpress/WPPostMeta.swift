import Foundation

public extension WordPressElements {
  struct PostMeta: Codable {
    public let key: CData
    public let value: CData

    enum CodingKeys: String, CodingKey {
      case key = "wp:metaKey"
      case value = "wp:metaValue"
    }
  }
}

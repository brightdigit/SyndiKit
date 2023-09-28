import Foundation

public extension OPML {
  struct Outline: Codable, Equatable {
    public let text: String
    public let title: String?
    public let description: String?
    public let type: OutlineType?
    public let url: URL?
    public let htmlUrl: URL?
    public let xmlUrl: URL?
    public let language: String?
    public let created: String?
    public let categories: ListString<String>?
    public let isComment: Bool?
    public let isBreakpoint: Bool?
    public let version: String?

    public let outlines: [Outline]?

    enum CodingKeys: String, CodingKey {
      case text
      case title
      case description
      case type
      case url
      case htmlUrl
      case xmlUrl
      case language
      case created
      case categories = "category"
      case isComment
      case isBreakpoint
      case version

      case outlines = "outline"
    }
  }
}

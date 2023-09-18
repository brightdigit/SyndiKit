import Foundation

public extension OPML {
  struct Outline: Codable, Equatable {
    public let text: String
    public let description: String?
    public let htmlUrl: String?
    public let language: String?
    public let title: String?
    public let type: String?
    public let version: String?
    public let xmlUrl: String?

    public let outlines: [Outline]?

    enum CodingKeys: String, CodingKey {
      case text
      case description
      case htmlUrl
      case language
      case title
      case type
      case version
      case xmlUrl

      case outlines = ""
    }
  }
}

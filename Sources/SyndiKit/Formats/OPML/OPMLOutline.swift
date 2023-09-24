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
    public let categories: [String]?
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

    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)

      text = try container.decode(String.self, forKey: .text)
      title = try container.decodeIfPresent(String.self, forKey: .title)
      description = try container.decodeIfPresent(String.self, forKey: .description)
      type = try container.decodeIfPresent(OutlineType.self, forKey: .type)
      url = try container.decodeIfPresent(URL.self, forKey: .url)
      htmlUrl = try container.decodeIfPresent(URL.self, forKey: .htmlUrl)
      xmlUrl = try container.decodeIfPresent(URL.self, forKey: .xmlUrl)
      language = try container.decodeIfPresent(String.self, forKey: .language)
      created = try container.decodeIfPresent(String.self, forKey: .created)
      isComment = try container.decodeIfPresent(Bool.self, forKey: .isComment)
      isBreakpoint = try container.decodeIfPresent(Bool.self, forKey: .isBreakpoint)
      version = try container.decodeIfPresent(String.self, forKey: .version)

      outlines = try container.decodeIfPresent([Outline].self, forKey: .outlines)

      categories = try container
        .decodeIfPresent(String.self, forKey: .categories)?
        .components(separatedBy: ",")
    }
  }
}

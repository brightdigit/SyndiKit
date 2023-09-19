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

      self.text = try container.decode(String.self, forKey: .text)
      self.title = try container.decodeIfPresent(String.self, forKey: .title)
      self.description = try container.decodeIfPresent(String.self, forKey: .description)
      self.type = try container.decodeIfPresent(OutlineType.self, forKey: .type)
      self.url = try container.decodeIfPresent(URL.self, forKey: .url)
      self.htmlUrl = try container.decodeIfPresent(URL.self, forKey: .htmlUrl)
      self.xmlUrl = try container.decodeIfPresent(URL.self, forKey: .xmlUrl)
      self.language = try container.decodeIfPresent(String.self, forKey: .language)
      self.created = try container.decodeIfPresent(String.self, forKey: .created)
      self.isComment = try container.decodeIfPresent(Bool.self, forKey: .isComment)
      self.isBreakpoint = try container.decodeIfPresent(Bool.self, forKey: .isBreakpoint)
      self.version = try container.decodeIfPresent(String.self, forKey: .version)

      self.outlines = try container.decodeIfPresent([Outline].self, forKey: .outlines)

      self.categories = try container
        .decodeIfPresent(String.self, forKey: .categories)?
        .components(separatedBy: ",")
    }
  }
}

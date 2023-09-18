import Foundation

public extension OPML {
  struct Outline: Codable, Equatable {
    public let text: String
    public let title: String?
    public let description: String?
    public let type: String?
    public let url: [String]
    public let htmlUrl: String?
    public let xmlUrl: String?
    public let language: String?
    public let created: String?
    public let categories: [String]?
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
      case version

      case outlines = ""
    }

    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)

      self.text = try container.decode(String.self, forKey: .text)
      self.title = try container.decodeIfPresent(String.self, forKey: .title)
      self.description = try container.decodeIfPresent(String.self, forKey: .description)
      self.type = try container.decodeIfPresent(String.self, forKey: .type)
      self.url = try container.decode([String].self, forKey: .url)
      self.htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
      self.xmlUrl = try container.decodeIfPresent(String.self, forKey: .xmlUrl)
      self.language = try container.decodeIfPresent(String.self, forKey: .language)
      self.created = try container.decodeIfPresent(String.self, forKey: .created)
      self.version = try container.decodeIfPresent(String.self, forKey: .version)
      self.outlines = try container.decodeIfPresent([Outline].self, forKey: .outlines)

      self.categories = try container
        .decodeIfPresent(String.self, forKey: .categories)?
        .components(separatedBy: ",")
    }
  }
}

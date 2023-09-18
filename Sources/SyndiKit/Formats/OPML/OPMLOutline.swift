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
    public let created: String?
    public let categories: [String]?

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
      case created
      case categories = "category"

      case outlines = ""
    }

    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.text = try container.decode(String.self, forKey: CodingKeys.text)
      self.description = try container.decodeIfPresent(String.self, forKey: .description)
      self.htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
      self.language = try container.decodeIfPresent(String.self, forKey: .language)
      self.title = try container.decodeIfPresent(String.self, forKey: .title)
      self.type = try container.decodeIfPresent(String.self, forKey: .type)
      self.version = try container.decodeIfPresent(String.self, forKey: .version)
      self.xmlUrl = try container.decodeIfPresent(String.self, forKey: .xmlUrl)
      self.created = try container.decodeIfPresent(String.self, forKey: .created)
      self.outlines = try container.decodeIfPresent([Outline].self, forKey: .outlines)

      let category = try container.decodeIfPresent(String.self, forKey: .categories)
      self.categories = category?.components(separatedBy: ",")
    }
  }
}

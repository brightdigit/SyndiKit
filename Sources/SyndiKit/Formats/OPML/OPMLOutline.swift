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
      let container: KeyedDecodingContainer<OPML.Outline.CodingKeys> = try decoder.container(keyedBy: OPML.Outline.CodingKeys.self)
      self.text = try container.decode(String.self, forKey: OPML.Outline.CodingKeys.text)
      self.description = try container.decodeIfPresent(String.self, forKey: OPML.Outline.CodingKeys.description)
      self.htmlUrl = try container.decodeIfPresent(String.self, forKey: OPML.Outline.CodingKeys.htmlUrl)
      self.language = try container.decodeIfPresent(String.self, forKey: OPML.Outline.CodingKeys.language)
      self.title = try container.decodeIfPresent(String.self, forKey: OPML.Outline.CodingKeys.title)
      self.type = try container.decodeIfPresent(String.self, forKey: OPML.Outline.CodingKeys.type)
      self.version = try container.decodeIfPresent(String.self, forKey: OPML.Outline.CodingKeys.version)
      self.xmlUrl = try container.decodeIfPresent(String.self, forKey: OPML.Outline.CodingKeys.xmlUrl)
      self.created = try container.decodeIfPresent(String.self, forKey: OPML.Outline.CodingKeys.created)
      self.outlines = try container.decodeIfPresent([OPML.Outline].self, forKey: OPML.Outline.CodingKeys.outlines)

      let category = try container.decodeIfPresent(String.self, forKey: OPML.Outline.CodingKeys.categories)
      self.categories = category?.components(separatedBy: ",")
    }
  }
}

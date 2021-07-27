public struct RSSItemCategory: Codable, RSSCategory {
  public var term: String {
    value
  }

  public let value: String
  public let domain: String?
  public let nicename: String?

  enum CodingKeys: String, CodingKey {
    case value = "#CDATA"
    case domain
    case nicename
  }

  public init(from decoder: Decoder) throws {
    let value: String
    let container : KeyedDecodingContainer<CodingKeys>?
    do {
      let _container = try decoder.container(keyedBy: CodingKeys.self)
      
      value = try _container.decode(String.self, forKey: .value)
      container = _container
    } catch {
      let _container = try decoder.singleValueContainer()
      
      value = try _container.decode(String.self)
      container = nil
    }
    self.value = value
    self.domain = try container?.decodeIfPresent(String.self, forKey: .domain)
    self.nicename = try container?.decodeIfPresent(String.self, forKey: .nicename)
  }
}

public struct RSSItemCategory: Codable, EntryCategory {
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

  public init(value: String, domain: String? = nil, nicename: String? = nil) {
    self.value = value
    self.domain = domain
    self.nicename = nicename
  }

  public init(from decoder: Decoder) throws {
    let value: String
    let container: KeyedDecodingContainer<CodingKeys>?
    do {
      let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
      value = try keyedContainer.decode(String.self, forKey: .value)
      container = keyedContainer
    } catch {
      let singleValueContainer = try decoder.singleValueContainer()
      value = try singleValueContainer.decode(String.self)
      container = nil
    }
    self.value = value
    domain = try container?.decodeIfPresent(String.self, forKey: .domain)
    nicename = try container?.decodeIfPresent(String.self, forKey: .nicename)
  }
}

public struct CData: Codable, Category {
  public var term: String {
    return value
  }

  let value: String

  enum CodingKeys: String, CodingKey {
    case value = "#CDATA"
  }

  public init(from decoder: Decoder) throws {
    let value: String
    do {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      value = try container.decode(String.self, forKey: .value)
    } catch {
      let container = try decoder.singleValueContainer()
      value = try container.decode(String.self)
    }
    self.value = value
  }
}
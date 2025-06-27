/// #CDATA XML element.
public struct CData: Codable, ExpressibleByStringLiteral, Equatable, Sendable {
  public enum CodingKeys: String, CodingKey {
    case value = "#CDATA"
  }

  public var description: String {
    value
  }

  /// String value of the #CDATA element.
  public let value: String

  public init(stringLiteral value: String) {
    self.value = value
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

public struct IntegerCodable: Codable, ExpressibleByIntegerLiteral {
  public let value: Int

  public init(integerLiteral value: Int) {
    self.value = value
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines)
    guard let value = Int(stringValue) else {
      throw DecodingError.typeMismatch(Int.self, .init(codingPath: decoder.codingPath, debugDescription: "Not Able to Parse String", underlyingError: nil))
    }
    self.value = value
  }
}

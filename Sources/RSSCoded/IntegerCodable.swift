

struct IntegerCodable: Codable, ExpressibleByIntegerLiteral {
  let value: Int

  init(integerLiteral value: Int) {
    self.value = value
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines)
    guard let value = Int(stringValue) else {
      throw DecodingError.typeMismatch(Int.self, .init(codingPath: decoder.codingPath, debugDescription: "Not Able to Parse String", underlyingError: nil))
    }
    self.value = value
  }
}

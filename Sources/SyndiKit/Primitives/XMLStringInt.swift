public struct XMLStringInt: Codable {
  public let value: Int

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self)
      .trimmingCharacters(in: .whitespacesAndNewlines)
    guard let value = Int(stringValue) else {
      let context = DecodingError.Context(codingPath: decoder.codingPath,
                                          debugDescription: "Not Able to Parse String Into Integer",
                                          underlyingError: nil)
      throw DecodingError.typeMismatch(Int.self, context)
    }
    self.value = value
  }
}

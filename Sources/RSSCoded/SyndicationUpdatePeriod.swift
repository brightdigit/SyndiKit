enum SyndicationUpdatePeriod: String, Codable {
  case hourly, daily, weekly, monthly, yearly

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines)
    guard let value = Self(rawValue: stringValue) else {
      throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Invalid Enum", underlyingError: nil))
    }
    self = value
  }
}

/// Describes the period over which the channel format is updated.
public enum SyndicationUpdatePeriod: String, Codable, Sendable {
  case hourly, daily, weekly, monthly, yearly

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue =
      try container
      .decode(String.self)
      .trimmingCharacters(in: .whitespacesAndNewlines)
    guard let value = Self(rawValue: stringValue) else {
      let context = DecodingError.Context(
        codingPath: decoder.codingPath,
        debugDescription: "Invalid Enum",
        underlyingError: nil
      )
      throw DecodingError.dataCorrupted(context)
    }
    self = value
  }
}

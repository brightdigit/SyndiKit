import Foundation

/// A struct representing the duration of an iTunes track.
public struct iTunesDuration: Codable, ExpressibleByFloatLiteral {
  /// The type used to represent a floating-point literal.
  public typealias FloatLiteralType = TimeInterval

  /// The value of the duration in seconds.
  public let value: TimeInterval

  /// Creates a new instance with the specified floating-point literal value.
  ///
  /// - Parameter value: The value of the duration in seconds.
  public init(floatLiteral value: TimeInterval) {
    self.value = value
  }

  /// Creates a new instance by decoding from the given decoder.
  ///
  /// - Parameter decoder: The decoder to read data from.
  /// - Throws: An error if reading from the decoder fails,
  /// or if the data is corrupted or invalid.
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self)
    guard let value = Self.timeInterval(stringValue) else {
      let context = DecodingError.Context(
        codingPath: decoder.codingPath,
        debugDescription: "Invalid time value",
        underlyingError: nil
      )
      throw DecodingError.dataCorrupted(context)
    }
    self.value = value
  }

  /// Creates a new instance from the given description string.
  ///
  /// - Parameter description: The description string representing the duration.
  /// - Returns: A new instance if the description is valid, otherwise `nil`.
  public init?(_ description: String) {
    guard let value = Self.timeInterval(description) else {
      return nil
    }
    self.value = value
  }

  /// Converts a time string to a `TimeInterval` value.
  ///
  /// - Parameter timeString: The time string to convert.
  /// - Returns: The `TimeInterval` value representing the time string,
  /// or `nil` if the string is invalid.
  internal static func timeInterval(_ timeString: String) -> TimeInterval? {
    let timeStrings = timeString.components(separatedBy: ":").prefix(3)
    let doubles = timeStrings.compactMap(Double.init)
    guard doubles.count == timeStrings.count else {
      return nil
    }
    return doubles.reduce(0) { partialResult, value in
      partialResult * 60.0 + value
    }
  }
}

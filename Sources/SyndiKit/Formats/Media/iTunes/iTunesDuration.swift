import Foundation
// swiftlint:disable:next type_name
public struct iTunesDuration: Codable, ExpressibleByFloatLiteral {
  public typealias FloatLiteralType = TimeInterval

  public let value: TimeInterval

  public init(floatLiteral value: TimeInterval) {
    self.value = value
  }

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

  public init?(_ description: String) {
    guard let value = Self.timeInterval(description) else {
      return nil
    }
    self.value = value
  }

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

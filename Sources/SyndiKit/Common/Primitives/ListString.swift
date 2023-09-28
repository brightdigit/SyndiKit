import Foundation

public struct ListString<Value: LosslessStringConvertible & Equatable>: Codable, Equatable {
  public let values: [Value]

  internal init(values: [Value]) {
    self.values = values
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let listString = try container.decode(String.self)
    let strings = listString.components(separatedBy: ",")
    let values = try strings
      .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
      .filter { !$0.isEmpty }
      .map(Self.createValueFrom)
    self.init(values: values)
  }

  static func createValueFrom(_ string: String) throws -> Value {
    guard let value: Value = .init(string) else {
      throw DecodingError.typeMismatch(
        Value.self,
        .init(codingPath: [], debugDescription: "Invalid value: \(string)")
      )
    }
    return value
  }

  public func encode(to _: Encoder) throws {
    fatalError()
  }
}

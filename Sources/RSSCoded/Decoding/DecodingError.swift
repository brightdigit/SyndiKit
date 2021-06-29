import Foundation

extension DecodingError {
  struct Collection: Error {
    let errors: [DecodingError]
  }

  static func failedAttempts(_ errors: [DecodingError]) -> Self {
    return DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Failed to ", underlyingError: Collection(errors: errors)))
  }
}

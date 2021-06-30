import Foundation

extension DecodingError {
  struct Collection: Error {
    let errors: [DecodingError]
  }

  static func failedAttempts(_ errors: [DecodingError]) -> Self {
    let context = DecodingError.Context(
      codingPath: [],
      debugDescription: "Failed to ",
      underlyingError: Collection(errors: errors)
    )
    return DecodingError.dataCorrupted(context)
  }
}

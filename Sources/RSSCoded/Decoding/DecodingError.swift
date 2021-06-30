import Foundation

extension DecodingError {
  struct Collection: Error {
    internal init?(errors: [DecodingError]) {
      guard errors.count > 1 else {
        return nil
      }
      self.errors = errors
    }

    let errors: [DecodingError]
  }

  static func failedAttempts(_ errors: [DecodingError]) -> Self {
    let context = DecodingError.Context(
      codingPath: [],
      debugDescription: "Failed to decode data with several decoders.",
      underlyingError: Collection(errors: errors) ?? errors.first
    )
    return DecodingError.dataCorrupted(context)
  }
}

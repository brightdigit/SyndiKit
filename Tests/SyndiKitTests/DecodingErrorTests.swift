import Testing

@testable import SyndiKit
@testable import SyndiKitTestSupport

#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

@Suite("Decoding Error Tests")
internal struct DecodingErrorTests {
  @Test("Empty failed attempts returns data corrupted error")
  func errorsEmpty() {
    let error = DecodingError.failedAttempts([:])

    guard case let DecodingError.dataCorrupted(context) = error else {
      Issue.record("Expected dataCorrupted error")
      return
    }

    #expect(context.underlyingError == nil)
  }

  @Test("Single failed attempt returns nested data corrupted error")
  func errorsOne() {
    let debugDescription = UUID().uuidString
    let error = DecodingError.failedAttempts([
      "Test": .dataCorrupted(.init(codingPath: [], debugDescription: debugDescription))
    ])

    guard case let DecodingError.dataCorrupted(parentContext) = error else {
      Issue.record("Expected dataCorrupted error")
      return
    }

    guard let decodingError = parentContext.underlyingError as? DecodingError else {
      Issue.record("Expected underlying error to be DecodingError")
      return
    }

    guard case let DecodingError.dataCorrupted(childContext) = decodingError else {
      Issue.record("Expected nested dataCorrupted error")
      return
    }

    #expect(childContext.debugDescription == debugDescription)
  }

  @Test("Multiple failed attempts returns error dictionary")
  func errorsMany() {
    let errors = [
      "Test1": DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "")),
      "Test2": DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "")),
    ]
    let error = DecodingError.failedAttempts(errors)

    guard case let DecodingError.dataCorrupted(context) = error else {
      Issue.record("Expected dataCorrupted error")
      return
    }

    guard let collection = context.underlyingError as? DecodingError.Dictionary else {
      Issue.record("Expected underlying error to be DecodingError.Dictionary")
      return
    }

    #expect(collection.errors.count == errors.count)
  }
}

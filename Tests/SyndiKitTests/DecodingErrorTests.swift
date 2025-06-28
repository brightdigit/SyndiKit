import Foundation
import XCTest

@testable import SyndiKit

internal final class DecodingErrorTests: XCTestCase {
  func testErrorsEmpty() {
    let error = DecodingError.failedAttempts([:])

    guard case let DecodingError.dataCorrupted(context) = error else {
      XCTFail()
      return
    }

    XCTAssertNil(context.underlyingError)
  }

  func testErrorsOne() {
    let debugDescription = UUID().uuidString
    let error = DecodingError.failedAttempts([
      "Test": .dataCorrupted(.init(codingPath: [], debugDescription: debugDescription))
    ])

    guard case let DecodingError.dataCorrupted(parentContext) = error else {
      XCTFail()
      return
    }

    guard let decodingError = parentContext.underlyingError as? DecodingError else {
      XCTFail()
      return
    }

    guard case let DecodingError.dataCorrupted(childContext) = decodingError else {
      XCTFail()
      return
    }

    XCTAssertEqual(childContext.debugDescription, debugDescription)
  }

  func testErrorsMany() {
    let errors = [
      "Test1": DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "")),
      "Test2": DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "")),
    ]
    let error = DecodingError.failedAttempts(errors)

    guard case let DecodingError.dataCorrupted(context) = error else {
      XCTFail()
      return
    }

    guard let collection = context.underlyingError as? DecodingError.Dictionary else {
      XCTFail()
      return
    }

    XCTAssertEqual(collection.errors.count, errors.count)
  }
}

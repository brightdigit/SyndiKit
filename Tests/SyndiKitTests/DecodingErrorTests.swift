import Foundation
@testable import SyndiKit
import XCTest

public final class DecodingErrorTests: XCTestCase {
  func testErrorsEmpty() {
    let error = DecodingError.failedAttempts([])

    guard case let DecodingError.dataCorrupted(context) = error else {
      XCTFail()
      return
    }

    XCTAssertNil(context.underlyingError)
  }

  func testErrorsOne() {
    let debugDescription = UUID().uuidString
    let error = DecodingError.failedAttempts([
      .dataCorrupted(.init(codingPath: [], debugDescription: debugDescription))
    ])

    guard case let DecodingError.dataCorrupted(context) = error else {
      XCTFail()
      return
    }

    guard let decodingError = context.underlyingError as? DecodingError else {
      XCTFail()
      return
    }

    guard case let DecodingError.dataCorrupted(context) = decodingError else {
      XCTFail()
      return
    }

    XCTAssertEqual(context.debugDescription, debugDescription)
  }

  func testErrorsMany() {
    let errors = [
      DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "")),
      DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: ""))
    ]
    let error = DecodingError.failedAttempts(errors)

    guard case let DecodingError.dataCorrupted(context) = error else {
      XCTFail()
      return
    }

    guard let collection = context.underlyingError as? DecodingError.Collection else {
      XCTFail()
      return
    }

    XCTAssertEqual(collection.errors.count, errors.count)
  }
}

@testable import SyndiKit
import XCTest
import XMLCoder

internal final class XMLStringIntTests: XCTestCase {
  internal func testDecodeValidXMLValue() throws {
    let expectedAge = 10
    let xmlStr = """
    <age>\(expectedAge)</age>
    """

    guard let data = xmlStr.data(using: .utf8) else {
      XCTFail("Expected data out of \(xmlStr)")
      return
    }

    let sut = try XMLDecoder().decode(XMLStringInt.self, from: data)

    XCTAssertEqual(sut.value, expectedAge)
  }

  internal func testDecodeInvalidXMLValue() throws {
    let xmlStr = """
    <age>invalid</age>
    """

    guard let data = xmlStr.data(using: .utf8) else {
      XCTFail("Expected data out of \(xmlStr)")
      return
    }

    XCTAssertThrowsError(try XMLDecoder().decode(XMLStringInt.self, from: data)) { error in
      XCTAssertNotNil(error as? DecodingError)
    }
  }
}

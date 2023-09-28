@testable import SyndiKit
import XCTest
import XMLCoder

internal final class UTF8EncodedURLTests: XCTestCase {
  internal func testDecode() throws {
    let expectedURL = URL(strict: "http://www.example.com/index.php")!
    let urlStr = """
    "\(expectedURL)"
    """

    guard let data = urlStr.data(using: .utf8) else {
      XCTFail("Expected data out of \(urlStr)")
      return
    }

    let sut = try JSONDecoder().decode(UTF8EncodedURL.self, from: data)

    XCTAssertEqual(sut.value, expectedURL)
    XCTAssertNil(sut.string)
  }
}

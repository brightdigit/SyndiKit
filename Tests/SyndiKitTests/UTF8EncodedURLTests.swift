import Testing
import XMLCoder

@testable import SyndiKit
@testable import SyndiKitTestSupport

#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

@Suite("UTF8 Encoded URL Tests")
internal struct UTF8EncodedURLTests {
  @Test("Decode UTF8 encoded URL from JSON")
  func decode() throws {
    let expectedURL = URL(strict: "http://www.example.com/index.php")!
    let urlStr = """
      "\(expectedURL)"
      """

    let data = try #require(urlStr.data(using: .utf8), "Expected data out of \(urlStr)")

    let sut = try JSONDecoder().decode(UTF8EncodedURL.self, from: data)

    #expect(sut.value == expectedURL)
    #expect(sut.string == nil)
  }
}

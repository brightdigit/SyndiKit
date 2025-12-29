import Testing
import XMLCoder

@testable import SyndiKit
@testable import SyndiKitTestSupport

#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

@Suite("XML String Int Tests")
internal struct XMLStringIntTests {
  @Test("Decode valid XML integer value")
  func decodeValidXMLValue() throws {
    let expectedAge = 10
    let xmlStr = """
      <age>\(expectedAge)</age>
      """

    let data = try #require(xmlStr.data(using: .utf8), "Expected data out of \(xmlStr)")

    let sut = try XMLDecoder().decode(XMLStringInt.self, from: data)

    #expect(sut.value == expectedAge)
  }

  @Test("Decode invalid XML integer value throws error")
  func decodeInvalidXMLValue() throws {
    let xmlStr = """
      <age>invalid</age>
      """

    let data = try #require(xmlStr.data(using: .utf8), "Expected data out of \(xmlStr)")

    #expect(throws: DecodingError.self) {
      try XMLDecoder().decode(XMLStringInt.self, from: data)
    }
  }
}

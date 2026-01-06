//
//  AuthorParsingTests.swift
//  SyndiKit
//
//  Created by Leo Dion.
//  Copyright © 2025 BrightDigit.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

import XCTest
import XMLCoder

@testable import SyndiKit
@testable import SyndiKitTestSupport

#if swift(<5.7)
  @preconcurrency import Foundation
#elseif swift(<6.0)
  import Foundation
#else
  public import Foundation
#endif

final class AuthorParsingTests: XCTestCase {
  // MARK: - RFC 822 Format Tests

  func testAuthorWithEmailAndName() throws {
    let xml = """
      <author>podcast@example.com (Jane Doe)</author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    XCTAssertEqual(author.name, "Jane Doe")
    XCTAssertEqual(author.email, "podcast@example.com")
    XCTAssertNil(author.uri)
  }

  func testAuthorWithEmailOnly() throws {
    let xml = """
      <author>webmaster@example.com</author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    XCTAssertEqual(author.name, "webmaster@example.com")
    XCTAssertEqual(author.email, "webmaster@example.com")
    XCTAssertNil(author.uri)
  }

  func testAuthorWithNameOnly() throws {
    let xml = """
      <author>John Doe</author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    XCTAssertEqual(author.name, "John Doe")
    XCTAssertNil(author.email)
    XCTAssertNil(author.uri)
  }

  func testAuthorWithComplexName() throws {
    let xml = """
      <author>doctor@example.com (Dr. John Q. Doe, Jr.)</author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    XCTAssertEqual(author.name, "Dr. John Q. Doe, Jr.")
    XCTAssertEqual(author.email, "doctor@example.com")
    XCTAssertNil(author.uri)
  }

  func testAuthorWithExtraWhitespace() throws {
    let xml = """
      <author>  podcast@example.com  ( Jane Doe )  </author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    XCTAssertEqual(author.name, "Jane Doe")
    XCTAssertEqual(author.email, "podcast@example.com")
    XCTAssertNil(author.uri)
  }

  // MARK: - Edge Cases

  func testAuthorWithEmptyString() throws {
    let xml = """
      <author></author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    XCTAssertEqual(author.name, "")
    XCTAssertNil(author.email)
    XCTAssertNil(author.uri)
  }

  func testAuthorWithMultipleParentheses() throws {
    let xml = """
      <author>test@example.com (John (Johnny) Doe)</author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    // Should extract content between first "(" and last ")"
    XCTAssertEqual(author.name, "John (Johnny) Doe")
    XCTAssertEqual(author.email, "test@example.com")
    XCTAssertNil(author.uri)
  }

  func testInternationalCharacters() throws {
    let xml = """
      <author>test@example.com (François Müller)</author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    XCTAssertEqual(author.name, "François Müller")
    XCTAssertEqual(author.email, "test@example.com")
    XCTAssertNil(author.uri)
  }

  // MARK: - Malformed Input Tests

  func testUnclosedParenthesis() throws {
    let xml = """
      <author>email@example.com (Name Without Closing</author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    // Without closing paren, falls through to email detection
    XCTAssertEqual(author.name, "email@example.com (Name Without Closing")
    XCTAssertEqual(author.email, "email@example.com (Name Without Closing")
    XCTAssertNil(author.uri)
  }

  func testMultipleAtSymbols() throws {
    let xml = """
      <author>user@@domain.com</author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    // Should be treated as name-only due to invalid email format
    XCTAssertEqual(author.name, "user@@domain.com")
    XCTAssertNil(author.email)
    XCTAssertNil(author.uri)
  }

  func testTextAfterParenthesis() throws {
    let xml = """
      <author>email@example.com (Display Name) extra text</author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    // Parser correctly extracts name from parentheses, extra text is ignored
    XCTAssertEqual(author.name, "Display Name")
    XCTAssertEqual(author.email, "email@example.com")
    XCTAssertNil(author.uri)
  }

  func testEmptyParentheses() throws {
    let xml = """
      <author>email@example.com ()</author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    // Should extract empty name from parentheses
    XCTAssertEqual(author.name, "")
    XCTAssertEqual(author.email, "email@example.com")
    XCTAssertNil(author.uri)
  }

  func testLeadingAtSymbol() throws {
    let xml = """
      <author>@example.com</author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    // Should be treated as name-only due to invalid email format
    XCTAssertEqual(author.name, "@example.com")
    XCTAssertNil(author.email)
    XCTAssertNil(author.uri)
  }

  func testTrailingAtSymbol() throws {
    let xml = """
      <author>username@</author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    // Should be treated as name-only due to invalid email format
    XCTAssertEqual(author.name, "username@")
    XCTAssertNil(author.email)
    XCTAssertNil(author.uri)
  }

  func testOnlyAtSymbol() throws {
    let xml = """
      <author>@</author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    // Should be treated as name-only
    XCTAssertEqual(author.name, "@")
    XCTAssertNil(author.email)
    XCTAssertNil(author.uri)
  }

  // MARK: - Atom Format Backward Compatibility

  func testAtomAuthorStillWorks() throws {
    let xml = """
      <author>
        <name>Jane Doe</name>
        <email>jane@example.com</email>
        <uri>https://example.com</uri>
      </author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    XCTAssertEqual(author.name, "Jane Doe")
    XCTAssertEqual(author.email, "jane@example.com")
    XCTAssertEqual(author.uri, URL(string: "https://example.com"))
  }

  func testAtomAuthorWithOnlyName() throws {
    let xml = """
      <author>
        <name>Jane Doe</name>
      </author>
      """
    let decoder = XMLCoder.XMLDecoder()
    let author = try decoder.decode(
      Author.self,
      from: Data(xml.utf8)
    )

    XCTAssertEqual(author.name, "Jane Doe")
    XCTAssertNil(author.email)
    XCTAssertNil(author.uri)
  }

  // MARK: - Encoding Tests

  func testAuthorRoundTrip() throws {
    let original = Author(
      name: "Jane Doe",
      email: "jane@example.com",
      uri: URL(string: "https://example.com")
    )

    let encoder = XMLCoder.XMLEncoder()
    let decoder = XMLCoder.XMLDecoder()

    let data = try encoder.encode(original)
    let decoded = try decoder.decode(Author.self, from: data)

    XCTAssertEqual(decoded.name, original.name)
    XCTAssertEqual(decoded.email, original.email)
    XCTAssertEqual(decoded.uri, original.uri)
  }

  func testAuthorRoundTripWithoutEmail() throws {
    let original = Author(name: "Jane Doe", email: nil, uri: nil)

    let encoder = XMLCoder.XMLEncoder()
    let decoder = XMLCoder.XMLDecoder()

    let data = try encoder.encode(original)
    let decoded = try decoder.decode(Author.self, from: data)

    XCTAssertEqual(decoded.name, original.name)
    XCTAssertNil(decoded.email)
    XCTAssertNil(decoded.uri)
  }

  // MARK: - Existing API Compatibility

  func testPublicInitializerStillWorks() {
    let author = Author(name: "Jane Doe")

    XCTAssertEqual(author.name, "Jane Doe")
    XCTAssertNil(author.email)
    XCTAssertNil(author.uri)
  }
}

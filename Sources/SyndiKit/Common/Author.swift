//
//  Author.swift
//  SyndiKit
//
//  Created by Leo Dion.
//  Copyright © 2025 BrightDigit.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the “Software”), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#if swift(<5.7)
  @preconcurrency import Foundation
#elseif swift(<6.0)
  import Foundation
#else
  public import Foundation
#endif

/// Represents a person, corporation, or similar entity.
///
/// Parses author information from multiple formats:
/// - **Atom format**: Separate `<name>`, `<email>`, `<uri>` child elements
/// - **RSS RFC 822 format**: "email@example.com (Display Name)"
/// - **Email only**: "email@example.com"
/// - **Name only**: "Display Name"
///
/// ## Examples
/// ```xml
/// <!-- RSS format -->
/// <managingEditor>podcast@example.com (Jane Doe)</managingEditor>
///
/// <!-- Atom format -->
/// <author>
///   <name>Jane Doe</name>
///   <email>podcast@example.com</email>
/// </author>
/// ```
public struct Author: Codable, Equatable, Sendable {
  internal enum CodingKeys: String, CodingKey {
    case name
    case email
    case uri
  }

  /// Conveys a human-readable name for the person.
  public let name: String

  /// Contains an email address for the person.
  public let email: String?

  /// Contains a home page for the person.
  public let uri: URL?

  /// Creates an author with only a name.
  /// - Parameter name: The name of the author.
  public init(name: String) {
    self.name = name
    email = nil
    uri = nil
  }

  internal init(name: String, email: String?, uri: URL?) {
    self.name = name
    self.email = email
    self.uri = uri
  }

  /// Creates a new instance by decoding from the given decoder.
  ///
  /// Supports both Atom format (structured child elements) and RSS RFC 822 format
  /// ("email@example.com (Display Name)").
  /// - Parameter decoder: The decoder to read data from.
  /// - Throws: An error if reading from the decoder fails.
  public init(from decoder: any Decoder) throws {
    // Try keyed container first (Atom format with child elements)
    if let keyedContainer = try? decoder.container(
      keyedBy: CodingKeys.self
    ),
      let decodedName = try? keyedContainer.decode(
        String.self,
        forKey: .name
      )
    {
      // Atom format with structured <name>, <email>, <uri>
      name = decodedName
      email = try keyedContainer.decodeIfPresent(
        String.self,
        forKey: .email
      )
      uri = try keyedContainer.decodeIfPresent(URL.self, forKey: .uri)
    } else {
      // Fall back to single value container (RSS format)
      let container = try decoder.singleValueContainer()
      let rawString = try container.decode(String.self)
      let parsed = Self.parseRFC822Author(rawString)
      name = parsed.name
      email = parsed.email
      uri = nil
    }
  }

  private static func parseRFC822Author(
    _ string: String
  ) -> (name: String, email: String?) {
    let trimmed = string.trimmingCharacters(
      in: .whitespacesAndNewlines
    )

    // Check for "email (name)" pattern
    if let openParen = trimmed.firstIndex(of: "("),
      let closeParen = trimmed.lastIndex(of: ")"),
      openParen < closeParen
    {
      // Extract email (before parentheses)
      let emailPart = trimmed[..<openParen]
        .trimmingCharacters(in: .whitespacesAndNewlines)

      // Extract name (inside parentheses)
      let nameStart = trimmed.index(after: openParen)
      let namePart = trimmed[nameStart..<closeParen]
        .trimmingCharacters(in: .whitespacesAndNewlines)

      return (
        name: String(namePart),
        email: emailPart.isEmpty ? nil : String(emailPart)
      )
    }

    // No parentheses found - check if it looks like an email
    if trimmed.contains("@"),
      !trimmed.starts(with: "@"),
      !trimmed.hasSuffix("@"),
      trimmed.filter({ $0 == "@" }).count == 1
    {
      // Email-only format
      return (name: trimmed, email: trimmed)
    }

    // Name-only format
    return (name: trimmed, email: nil)
  }

  /// Encodes this value into the given encoder.
  /// - Parameter encoder: The encoder to write data to.
  /// - Throws: An error if encoding fails.
  public func encode(to encoder: any Encoder) throws {
    // Try to preserve format by encoding with keyed container
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encodeIfPresent(email, forKey: .email)
    try container.encodeIfPresent(uri, forKey: .uri)
  }
}

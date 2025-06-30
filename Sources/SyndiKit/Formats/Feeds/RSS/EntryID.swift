//
//  EntryID.swift
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
#else
  import Foundation
#endif

/// An identifier for an entry based on the RSS guid.
///
/// - Note: This enum conforms to
/// ``Codable``, ``Equatable``, and ``LosslessStringConvertible``.
public enum EntryID: Codable, Equatable, LosslessStringConvertible, Sendable {
  /// An identifier in URL format.
  case url(URL)

  /// An identifier in UUID format.
  case uuid(UUID)

  /// An identifier in string path format.
  ///
  /// This format is commonly used by YouTube's RSS feed, in the format of:
  /// ```
  /// yt:video:(YouTube Video ID)
  /// ```
  case path([String], separatedBy: String)

  /// An identifier in plain un-parsable string format.
  case string(String)

  /// A string representation of the entry identifier.
  public var description: String {
    let string: String
    switch self {
    case let .url(url):
      string = url.absoluteString

    case let .uuid(uuid):
      string = uuid.uuidString.lowercased()

    case let .path(components, separatedBy: separator):
      string = components.joined(separator: separator)

    case let .string(value):
      string = value
    }
    return string
  }

  /// Initializes an ``EntryID`` from a string.
  ///
  /// - Parameter description: The string representation of the entry identifier.
  /// - Note: This initializer will never return a ``nil`` instance.
  /// To avoid the ``Optional`` result, use `init(string:)` instead.
  public init?(_ description: String) {
    self.init(string: description)
  }

  /// Initializes an ``EntryID`` from a string.
  ///
  /// - Parameter string: The string representation of the entry identifier.
  /// - Note: Use this initializer instead of `init(_:)` to avoid the ``Optional`` result.
  public init(string: String) {
    if let url = URL(strict: string) {
      self = .url(url)
    } else if let uuid = UUID(uuidString: string) {
      self = .uuid(uuid)
    } else {
      self = Self.parsePathOrString(string)
    }
  }

  /// Initializes an ``EntryID`` from a decoder.
  ///
  /// - Parameter decoder: The decoder to read data from.
  /// - Throws: An error if the decoding process fails.
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let string = try container.decode(String.self)
    self.init(string: string)
  }

  private static func parsePathOrString(_ string: String) -> EntryID {
    let colonComponents = string.components(separatedBy: ":")
    if colonComponents.count > 1 {
      return .path(colonComponents, separatedBy: ":")
    }

    let slashComponents = string.components(separatedBy: "/")
    if slashComponents.count > 1 {
      return .path(slashComponents, separatedBy: "/")
    }

    return .string(string)
  }

  /// Encodes the ``EntryID`` into the given encoder.
  ///
  /// - Parameter encoder: The encoder to write data to.
  /// - Throws: An error if the encoding process fails.
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(description)
  }
}

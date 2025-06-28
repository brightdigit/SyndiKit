//
//  Enclosure.swift
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

#if swift(>=5.7)
  @preconcurrency import Foundation
#else
  import Foundation
#endif

/// A struct representing an enclosure for a resource.
public struct Enclosure: Codable, Sendable {
  internal enum CodingKeys: String, CodingKey {
    case url
    case type
    case length
  }

  /// The URL of the enclosure.
  public let url: URL

  /// The type of the enclosure.
  public let type: String

  /// The length of the enclosure, if available.
  public let length: Int?

  /// Initializes a new ``Enclosure`` instance from a decoder.
  ///
  /// - Parameter decoder: The decoder to read data from.
  /// - Throws: An error if the decoding process fails.
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    url = try container.decode(UTF8EncodedURL.self, forKey: .url).value
    type = try container.decode(String.self, forKey: .type)
    length = try Self.decodeLength(from: container)
  }

  /// Decodes the length of the enclosure from the given container.
  ///
  /// - Parameter container: The container to decode from.
  /// - Returns: The length of the enclosure, or ``nil`` if not available.
  /// - Throws: An error if the decoding process fails.
  private static func decodeLength(
    from container: KeyedDecodingContainer<CodingKeys>
  ) throws -> Int? {
    if container.contains(.length) {
      return try decodeLengthValue(from: container)
    } else {
      return nil
    }
  }

  private static func decodeLengthValue(
    from container: KeyedDecodingContainer<CodingKeys>
  ) throws -> Int? {
    do {
      return try container.decode(Int.self, forKey: .length)
    } catch {
      let lengthString = try container.decode(String.self, forKey: .length)
      return try parseLengthString(lengthString, originalError: error)
    }
  }

  private static func parseLengthString(
    _ lengthString: String,
    originalError: Error
  ) throws -> Int? {
    if lengthString.isEmpty {
      return nil
    } else if let length = Int(lengthString) {
      return length
    } else {
      throw originalError
    }
  }
}

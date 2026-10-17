//
//  AtomContent.swift
//  SyndiKit
//
//  Created by Leo Dion.
//  Copyright © 2026 BrightDigit.
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

#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

/// A `<content>` element of an Atom entry.
///
/// An entry may carry several, such as App Store customer reviews with both
/// `<content type="text">` and `<content type="html">`.
public struct AtomContent: Codable, Sendable {
  /// The coding keys used for encoding and decoding.
  public enum CodingKeys: String, CodingKey {
    case type
    case value = ""
  }

  /// The `type` attribute, such as `text`, `html`, or `xhtml`.
  public let type: String?

  /// The element's text.
  public let value: String

  /// Creates a new instance by decoding from the given decoder.
  /// - Parameter decoder: The decoder to read data from.
  /// - Throws: An error if reading from the decoder fails.
  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    value = try container.decodeIfPresent(String.self, forKey: .value) ?? ""
  }
}

extension Array where Element == AtomContent {
  /// The first element whose `type` is one of `types`, or else the first element.
  internal func preferring(_ types: Set<String>) -> AtomContent? {
    first { $0.type.map(types.contains) ?? false } ?? first
  }
}

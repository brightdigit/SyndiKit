//
//  SynDecoder.swift
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

import Foundation

import XMLCoder

/// An object that decodes instances of Feedable from JSON or XML objects.
/// ## Topics
///
/// ### Creating a Decoder
///
/// - ``init()``
///
/// ### Decoding
///
/// - ``decode(_:)``
@available(macOS 13.0, *)
public final class SynDecoder: Sendable {
  private static let defaultTypes: [DecodableFeed.Type] = [
    RSSFeed.self,
    AtomFeed.self,
    JSONFeed.self,
  ]

  private let defaultJSONDecoderSetup: @Sendable (JSONDecoder) -> Void
  private let defaultXMLDecoderSetup: @Sendable (XMLCoder.XMLDecoder) -> Void
  private let types: [DecodableFeed.Type]

  private let defaultXMLDecoder: XMLDecoder

  private let defaultJSONDecoder: JSONDecoder

  private let decodings: [DecoderSource: [String: AnyDecoding]]

  internal init(
    types: [DecodableFeed.Type]? = nil,
    defaultJSONDecoderSetup: (@Sendable (JSONDecoder) -> Void)? = nil,
    defaultXMLDecoderSetup: (@Sendable (XMLCoder.XMLDecoder) -> Void)? = nil
  ) {
    let resolvedTypes = types ?? Self.defaultTypes
    let jsonSetup = defaultJSONDecoderSetup ?? Self.setupJSONDecoder(_:)
    let xmlSetup = defaultXMLDecoderSetup ?? Self.setupXMLDecoder(_:)

    let xmlDecoder = XMLDecoder {
      let decoder = XMLCoder.XMLDecoder()
      xmlSetup(decoder)
      return decoder
    }
    let jsonDecoder = JSONDecoder()
    jsonSetup(jsonDecoder)

    let decodings = Self.createDecodings(
      from: resolvedTypes,
      xmlDecoder: xmlDecoder,
      jsonDecoder: jsonDecoder
    )

    self.types = resolvedTypes
    self.defaultJSONDecoderSetup = jsonSetup
    self.defaultXMLDecoderSetup = xmlSetup
    defaultXMLDecoder = xmlDecoder
    defaultJSONDecoder = jsonDecoder
    self.decodings = decodings
  }

  /// Creates an instance of ``RSSDecoder``
  public convenience init() {
    self.init(types: nil, defaultJSONDecoderSetup: nil, defaultXMLDecoderSetup: nil)
  }

  /// Returns a ``Feedable`` object of the type you specify, decoded from a JSON object.
  /// - Parameter data: The JSON or XML object to decode.
  /// - Returns: A ``Feedable`` object
  ///
  /// If the data is not valid RSS, this method throws the
  /// `DecodingError.dataCorrupted(_:)` error.
  /// If a value within the RSS fails to decode,
  /// this method throws the corresponding error.
  ///
  /// ```swift
  /// let data = Data(contentsOf: "empowerapps-show.xml")!
  /// let decoder = SynDecoder()
  /// let feed = try decoder.decode(data)
  ///
  /// print(feed.title) // Prints "Empower Apps"
  /// ```
  public func decode(_ data: Data) throws -> Feedable {
    let firstByte = try Self.getFirstByte(from: data)
    let source = try Self.getSource(from: firstByte)
    guard let decodings = decodings[source] else {
      throw DecodingError.failedAttempts([:])
    }
    return try Self.decodeFeed(data, with: decodings)
  }
}

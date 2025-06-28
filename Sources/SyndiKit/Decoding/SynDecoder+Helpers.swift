//
//  SynDecoder+Helpers.swift
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

extension SynDecoder {
  @Sendable
  internal static func setupJSONDecoder(_ decoder: JSONDecoder) {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .custom(DateFormatterDecoder.RSS.decoder.decode(from:))
  }

  @Sendable
  internal static func setupXMLDecoder(_ decoder: XMLDecoder) {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .custom(DateFormatterDecoder.RSS.decoder.decode(from:))
    decoder.trimValueWhitespaces = false
  }

  internal static func createDecodings(
    from types: [DecodableFeed.Type],
    xmlDecoder: XMLDecoder,
    jsonDecoder: JSONDecoder
  ) -> [DecoderSource: [String: AnyDecoding]] {
    types.map { type -> (DecoderSource, AnyDecoding) in
      let source = type.source
      let decoder = Self.createDecoder(
        for: source,
        xmlDecoder: xmlDecoder,
        jsonDecoder: jsonDecoder
      )
      return (source.source, type.anyDecoding(using: decoder))
    }
    .reduce(into: [DecoderSource: [(String, AnyDecoding)]]()) { dict, pair in
      let (source, decoding) = pair
      dict[source, default: []].append((type(of: decoding).label, decoding))
    }
    .mapValues { Dictionary(uniqueKeysWithValues: $0) }
  }

  internal static func createDecoder(
    for source: DecoderSetup,
    xmlDecoder: XMLDecoder,
    jsonDecoder: JSONDecoder
  ) -> TypeDecoder {
    let setup = source as? CustomDecoderSetup
    switch (source.source, setup?.setup(decoder:)) {
    case let (.xml, .some(setup)):
      let xml = XMLDecoder()
      setup(xml)
      return xml

    case let (.json, .some(setup)):
      let json = JSONDecoder()
      setup(json)
      return json

    case (.xml, .none):
      return xmlDecoder

    case (.json, .none):
      return jsonDecoder
    }
  }

  internal static func decodeFeed(
    _ data: Data,
    with decodings: [String: AnyDecoding]
  ) throws -> Feedable {
    var errors = [String: DecodingError]()
    for (label, decoding) in decodings {
      do {
        return try decoding.decodeFeed(data: data)
      } catch let decodingError as DecodingError {
        errors[label] = decodingError
      }
    }
    throw DecodingError.failedAttempts(errors)
  }

  internal static func getFirstByte(from data: Data) throws -> UInt8 {
    guard let firstByte = data.first else {
      throw DecodingError.dataCorrupted(
        .init(codingPath: [], debugDescription: "Empty Data.")
      )
    }
    return firstByte
  }

  internal static func getSource(from firstByte: UInt8) throws -> DecoderSource {
    guard let source = DecoderSource(rawValue: firstByte) else {
      throw DecodingError.dataCorrupted(
        .init(
          codingPath: [],
          debugDescription: "Unmatched First Byte: \(firstByte)"
        )
      )
    }
    return source
  }
}

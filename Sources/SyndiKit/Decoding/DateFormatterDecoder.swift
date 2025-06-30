//
//  DateFormatterDecoder.swift
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

#if swift(>=5.7)
  @preconcurrency import Foundation
#else
  import Foundation
#endif

internal struct DateFormatterDecoder: Sendable {
  internal enum RSS: Sendable {
    private static let dateFormatStrings = [
      "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX",
      "yyyy-MM-dd'T'HH:mm:ssXXXXX",
      "E, d MMM yyyy HH:mm:ss zzz",
      "yyyy-MM-dd HH:mm:ss",
    ]

    internal static let decoder = DateFormatterDecoder(
      basedOnFormats: Self.dateFormatStrings
    )
  }

  private let formatters: [DateFormatter]

  internal init(basedOnFormats formats: [String]) {
    formatters = formats.map(Self.isoPOSIX(withFormat:))
  }

  private static func isoPOSIX(withFormat dateFormat: String) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = dateFormat
    return formatter
  }

  internal func decodeString(_ dateStr: String) -> Date? {
    for formatter in formatters {
      if let date = formatter.date(from: dateStr) {
        return date
      }
    }
    return nil
  }

  @Sendable
  internal func decode(from decoder: Decoder) throws -> Date {
    let container = try decoder.singleValueContainer()
    let dateStr = try container.decode(String.self)

    if let date = decodeString(dateStr) {
      return date
    }

    let context = DecodingError.Context(
      codingPath: decoder.codingPath,
      debugDescription: "Invalid Date from '\(dateStr)'"
    )
    throw DecodingError.dataCorrupted(context)
  }

  @Sendable
  internal static func decodeDateHandlingEmpty(from decoder: Decoder) throws -> Date {
    let container = try decoder.singleValueContainer()
    let dateStr = try container.decode(String.self)

    // Handle empty strings gracefully by throwing a specific error
    if dateStr.isEmpty {
      let context = DecodingError.Context(
        codingPath: decoder.codingPath,
        debugDescription: "Empty Date string"
      )
      throw DecodingError.dataCorrupted(context)
    }

    // Try to decode with the RSS decoder
    if let date = RSS.decoder.decodeString(dateStr) {
      return date
    }

    let context = DecodingError.Context(
      codingPath: decoder.codingPath,
      debugDescription: "Invalid Date from '\(dateStr)'"
    )
    throw DecodingError.dataCorrupted(context)
  }

  @Sendable
  internal static func decodeDateOptional(from decoder: Decoder) throws -> Date? {
    let container = try decoder.singleValueContainer()
    let dateStr = try container.decode(String.self)

    // Handle empty strings gracefully by returning nil
    if dateStr.isEmpty {
      return nil
    }

    // Try to decode with the RSS decoder
    return RSS.decoder.decodeString(dateStr)
  }
}

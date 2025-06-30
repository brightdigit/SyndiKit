//
//  SyndicationUpdatePeriod.swift
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
  internal import Foundation
#else
  import Foundation
#endif

/// Describes the period over which the channel format is updated.
public enum SyndicationUpdatePeriod: String, Codable, Sendable {
  case hourly, daily, weekly, monthly, yearly

  public init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue =
      try container
      .decode(String.self)
      .trimmingCharacters(in: .whitespacesAndNewlines)
    guard let value = Self(rawValue: stringValue) else {
      let context = DecodingError.Context(
        codingPath: decoder.codingPath,
        debugDescription: "Invalid Enum",
        underlyingError: nil
      )
      throw DecodingError.dataCorrupted(context)
    }
    self = value
  }
}

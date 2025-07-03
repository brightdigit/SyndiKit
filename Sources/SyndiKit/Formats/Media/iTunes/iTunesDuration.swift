//
//  iTunesDuration.swift
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

#if swift(<6.1)
  import Foundation
#else
  public import Foundation
#endif

// swift-format-ignore: TypeNamesShouldBeCapitalized
/// A struct representing the duration of an iTunes track.
public struct iTunesDuration: Codable, ExpressibleByFloatLiteral, Sendable {
  /// The type used to represent a floating-point literal.
  public typealias FloatLiteralType = TimeInterval

  /// The value of the duration in seconds.
  public let value: TimeInterval

  /// Creates a new instance with the specified floating-point literal value.
  ///
  /// - Parameter value: The value of the duration in seconds.
  public init(floatLiteral value: TimeInterval) {
    self.value = value
  }

  /// Creates a new instance by decoding from the given decoder.
  ///
  /// - Parameter decoder: The decoder to read data from.
  /// - Throws: An error if reading from the decoder fails,
  /// or if the data is corrupted or invalid.
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self)
    guard let value = Self.timeInterval(stringValue) else {
      let context = DecodingError.Context(
        codingPath: decoder.codingPath,
        debugDescription: "Invalid time value",
        underlyingError: nil
      )
      throw DecodingError.dataCorrupted(context)
    }
    self.value = value
  }

  /// Creates a new instance from the given description string.
  ///
  /// - Parameter description: The description string representing the duration.
  /// - Returns: A new instance if the description is valid, otherwise ``nil``.
  public init?(_ description: String) {
    guard let value = Self.timeInterval(description) else {
      return nil
    }
    self.value = value
  }

  /// Converts a time string to a ``TimeInterval`` value.
  ///
  /// - Parameter timeString: The time string to convert.
  /// - Returns: The ``TimeInterval`` value representing the time string,
  /// or ``nil`` if the string is invalid.
  internal static func timeInterval(_ timeString: String) -> TimeInterval? {
    let timeStrings = timeString.components(separatedBy: ":").prefix(3)
    let doubles = timeStrings.compactMap(Double.init)
    guard doubles.count == timeStrings.count else {
      return nil
    }
    return doubles.reduce(0) { partialResult, value in
      partialResult * 60.0 + value
    }
  }
}

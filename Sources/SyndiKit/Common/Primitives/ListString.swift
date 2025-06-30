//
//  ListString.swift
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

import Foundation

public struct ListString<
  Value: LosslessStringConvertible & Equatable & Sendable
>: Codable, Equatable, Sendable {
  public let values: [Value]

  internal init(values: [Value]) {
    self.values = values
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let listString = try container.decode(String.self)
    let strings = listString.components(separatedBy: ",")
    let values =
      try strings
      .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
      .filter { !$0.isEmpty }
      .map(Self.createValueFrom)
    self.init(values: values)
  }

  private static func createValueFrom(_ string: String) throws -> Value {
    guard let value: Value = .init(string) else {
      throw DecodingError.typeMismatch(
        Value.self,
        .init(codingPath: [], debugDescription: "Invalid value: \(string)")
      )
    }
    return value
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    let strings = values.map(String.init)
    let listString = strings.joined(separator: ",")
    try container.encode(listString)
  }
}

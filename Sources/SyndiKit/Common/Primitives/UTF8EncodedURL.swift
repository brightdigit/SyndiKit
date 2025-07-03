//
//  UTF8EncodedURL.swift
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
#elseif swift(<6.1)
  import Foundation
#else
  internal import Foundation
#endif

internal struct UTF8EncodedURL: Codable, Sendable {
  internal let value: URL
  internal let string: String?

  internal init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    do {
      value = try container.decode(URL.self)
      string = nil
    } catch let error as DecodingError {
      let string = try container.decode(String.self)
      let encodedURL = try Self.encodedURL(from: string, error: error)
      value = encodedURL
      self.string = string
    }
  }

  private static func encodedURL(
    from string: String,
    error: DecodingError
  ) throws -> URL {
    let encodedURLString = string.addingPercentEncoding(
      withAllowedCharacters: .urlQueryAllowed
    )
    let encodedURL = encodedURLString.flatMap(URL.init(string:))
    guard let encodedURL = encodedURL else {
      throw error
    }
    return encodedURL
  }

  internal func encode(to encoder: any Encoder) throws {
    var container = encoder.singleValueContainer()
    if let string = string {
      try container.encode(string)
    } else {
      try container.encode(value)
    }
  }
}

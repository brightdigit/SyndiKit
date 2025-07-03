//
//  WordPressPost+Hashable.swift
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

extension WordPressPost: Hashable {
  /// Compares two WordPressPost instances for equality based on their IDs.
  /// - Parameters:
  ///   - lhs: The left-hand side WordPressPost to compare.
  ///   - rhs: The right-hand side WordPressPost to compare.
  /// - Returns: `true` if the posts have the same ID, `false` otherwise.
  public static func == (lhs: WordPressPost, rhs: WordPressPost) -> Bool {
    lhs.id == rhs.id
  }

  /// Hashes the WordPressPost based on its ID.
  /// - Parameter hasher: The hasher to use for combining the hash value.
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

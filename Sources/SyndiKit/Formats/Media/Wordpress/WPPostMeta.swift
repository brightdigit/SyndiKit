//
//  WPPostMeta.swift
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

/// A typealias for `WordPressElements.PostMeta`.
public typealias WPPostMeta = WordPressElements.PostMeta

extension WordPressElements {
  /// A struct representing metadata for a WordPress post.
  public struct PostMeta: Codable, Sendable {
    /// The coding keys for encoding and decoding.
    internal enum CodingKeys: String, CodingKey {
      case key = "wp:metaKey"
      case value = "wp:metaValue"
    }

    /// The key of the metadata.
    public let key: CData

    /// The value of the metadata.
    public let value: CData

    /// A struct representing an Atom category.
    ///     Initializes a new ``PostMeta`` instance.
    ///
    ///     - Parameters:
    ///       - key: The key of the metadata.
    ///       - value: The value of the metadata.
    /// - SeeAlso: ``EntryCategory``
    public init(key: String, value: String) {
      self.key = .init(stringLiteral: key)
      self.value = .init(stringLiteral: value)
    }
  }
}

extension WordPressElements.PostMeta: Equatable {
  /// A struct representing an Atom category.
  ///   Checks if two ``PostMeta`` instances are equal.
  ///
  ///   - Parameters:
  ///     - lhs: The left-hand side ``PostMeta`` instance.
  ///     - rhs: The right-hand side ``PostMeta`` instance.
  ///
  ///   - Returns: ``true`` if the two instances are equal, ``false`` otherwise.
  /// - SeeAlso: ``EntryCategory``
  public static func == (
    lhs: WordPressElements.PostMeta,
    rhs: WordPressElements.PostMeta
  ) -> Bool {
    lhs.key == rhs.key
      && lhs.value == rhs.value
  }
}

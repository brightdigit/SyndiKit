//
//  WPCategory.swift
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

/// A typealias for the `WordPressElements.Category` type.
public typealias WPCategory = WordPressElements.Category

// swiftlint:disable nesting
extension WordPressElements {
  /// A struct representing a category in WordPress.
  public struct Category: Codable, Sendable {
    /// The coding keys for the ``Category`` struct.
    internal enum CodingKeys: String, CodingKey {
      case termID = "wp:termId"
      case niceName = "wp:categoryNicename"
      case parent = "wp:categoryParent"
      case name = "wp:catName"
    }

    /// The unique identifier of the category.
    public let termID: Int

    /// The nice name of the category.
    public let niceName: CData

    /// The parent category of the category.
    public let parent: CData

    /// The name of the category.
    public let name: String

    /// A struct representing an Atom category.
    ///     Initializes a new ``Category`` instance.
    ///
    ///     - Parameters:
    ///       - termID: The unique identifier of the category.
    ///       - niceName: The nice name of the category.
    ///       - parent: The parent category of the category.
    ///       - name: The name of the category.
    /// - SeeAlso: ``EntryCategory``
    public init(termID: Int, niceName: CData, parent: CData, name: String) {
      self.termID = termID
      self.niceName = niceName
      self.parent = parent
      self.name = name
    }
  }
}

extension WordPressElements.Category: Equatable {
  /// Checks if two ``Category`` instances are equal.
  public static func == (
    lhs: WordPressElements.Category,
    rhs: WordPressElements.Category
  ) -> Bool {
    lhs.termID == rhs.termID
      && lhs.niceName == rhs.niceName
      && lhs.parent == rhs.parent
      && lhs.name == rhs.name
  }
}

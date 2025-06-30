//
//  Entryable.swift
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

/// Basic Feed type with abstract properties.
public protocol Entryable: Sendable {
  /// Unique Identifier of the Item.
  var id: EntryID { get }
  /// The URL of the item.
  var url: URL? { get }
  /// The title of the item.
  var title: String { get }
  /// HTML content of the item.
  var contentHtml: String? { get }
  /// The item synopsis.
  var summary: String? { get }
  /// Indicates when the item was published.
  var published: Date? { get }
  /// The author of the item.
  var authors: [Author] { get }
  /// Includes the item in one or more categories.
  var categories: [any EntryCategory] { get }
  /// Creator of the item.
  var creators: [String] { get }
  /// Abstraction of Podcast episode or Youtube video info.
  var media: MediaContent? { get }
  /// Image URL of the Item.
  var imageURL: URL? { get }
}

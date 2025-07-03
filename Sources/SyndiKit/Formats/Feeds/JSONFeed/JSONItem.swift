//
//  JSONItem.swift
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
  public import Foundation
#endif

/// A struct representing an Atom category.
/// A struct representing an item in JSON format.
/// - SeeAlso: ``EntryCategory``
public struct JSONItem: Codable, Sendable {
  /// The unique identifier of the item.
  public let guid: EntryID

  /// The URL associated with the item.
  public let url: URL?

  /// The title of the item.
  public let title: String

  /// The HTML content of the item.
  public let contentHtml: String?

  /// A summary of the item.
  public let summary: String?

  /// The date the item was published.
  public let datePublished: Date?

  /// The author of the item.
  public let author: Author?
}

extension JSONItem: Entryable {
  /// A struct representing an Atom category.
  ///   Returns an array of authors for the item.
  /// - SeeAlso: ``EntryCategory``
  public var authors: [Author] {
    guard let author = author else {
      return []
    }
    return [author]
  }

  /// The URL of the item's image.
  public var imageURL: URL? {
    nil
  }

  /// A struct representing an Atom category.
  ///   An array of creators associated with the item.
  /// - SeeAlso: ``EntryCategory``
  public var creators: [String] {
    []
  }

  /// The date the item was published.
  public var published: Date? {
    datePublished
  }

  /// The unique identifier of the item.
  public var id: EntryID {
    guid
  }

  /// A struct representing an Atom category.
  ///   An array of categories associated with the item.
  /// - SeeAlso: ``EntryCategory``
  public var categories: [EntryCategory] {
    []
  }

  /// The media content associated with the item.
  public var media: MediaContent? {
    nil
  }
}

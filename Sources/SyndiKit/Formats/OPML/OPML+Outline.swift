//
//  OPML+Outline.swift
//  SyndiKit
//
//  Created by Leo Dion.
//  Copyright © 2026 BrightDigit.
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
#elseif swift(<6.0)
  import Foundation
#else
  public import Foundation
#endif

extension OPML {
  /// A struct representing an outline element in an OPML document.
  /// Outlines can represent feed subscriptions, categories, or other hierarchical
  /// content. They can contain nested outlines and various metadata like URLs,
  /// types, and descriptions.
  public struct Outline: Codable, Equatable, Sendable {
    /// Coding keys for encoding and decoding outline elements.
    public enum CodingKeys: String, CodingKey {
      case text
      case title
      case description
      case type
      case url
      case htmlUrl
      case xmlUrl
      case language
      case created
      case categories = "category"
      case isComment
      case isBreakpoint
      case version

      case outlines = "outline"
    }

    /// The text content of the outline element.
    public let text: String
    /// The title of the outline element.
    public let title: String?
    /// A description of the outline element.
    public let description: String?
    /// The type of outline (rss, link, or include).
    public let type: OutlineType?
    /// A URL associated with the outline element.
    public let url: URL?
    /// The URL of the HTML page associated with the feed.
    public let htmlUrl: URL?
    /// The URL of the XML feed.
    public let xmlUrl: URL?
    /// The language code for the outline element.
    public let language: String?
    /// The creation date of the outline element.
    public let created: String?
    /// A comma-separated list of category names.
    public let categories: ListString<String>?
    // swiftlint:disable:next discouraged_optional_boolean
    /// Whether this outline is a comment.
    public let isComment: Bool?
    // swiftlint:disable:next discouraged_optional_boolean
    /// Whether this outline is a breakpoint.
    public let isBreakpoint: Bool?
    /// The version of the outline element.
    public let version: String?

    /// Nested outline elements.
    public let outlines: [Outline]?
  }
}

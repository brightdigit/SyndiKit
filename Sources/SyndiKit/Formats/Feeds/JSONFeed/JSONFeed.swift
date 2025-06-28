//
//  JSONFeed.swift
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
  @preconcurrency import Foundation
#else
  import Foundation
#endif

/// A struct representing an Atom category.
/// A struct representing a JSON feed.
///
/// - Note: This struct conforms to the ``DecodableFeed`` protocol.
///
/// - SeeAlso: ``DecodableFeed``
/// - SeeAlso: ``EntryCategory``
public struct JSONFeed: Sendable {
  /// The version of the JSON feed.
  public let version: URL

  /// The title of the JSON feed.
  public let title: String

  /// The URL of the home page associated with the feed.
  public let homePageUrl: URL

  /// A description of the JSON feed.
  public let description: String?

  /// The author of the feed.
  public let author: Author?

  /// The items in the JSON feed.
  public let items: [JSONItem]
}

extension JSONFeed: DecodableFeed {
  /// The source of the decoder for JSON feed.
  internal static let source: DecoderSetup = DecoderSource.json

  /// The label for the JSON feed.
  internal static let label: String = "JSON"

  /// The YouTube channel ID associated with the feed.
  public var youtubeChannelID: String? {
    nil
  }

  /// The children of the JSON feed.
  public var children: [Entryable] {
    items
  }

  /// The summary of the JSON feed.
  public var summary: String? {
    description
  }

  /// The site URL associated with the feed.
  public var siteURL: URL? {
    homePageUrl
  }

  /// The last updated date of the JSON feed.
  public var updated: Date? {
    nil
  }

  /// The copyright information of the JSON feed.
  public var copyright: String? {
    nil
  }

  /// The image URL associated with the feed.
  public var image: URL? {
    nil
  }

  /// The syndication update information of the JSON feed.
  public var syndication: SyndicationUpdate? {
    nil
  }

  /// The authors of the JSON feed.
  public var authors: [Author] {
    guard let author = author else {
      return []
    }
    return [author]
  }
}

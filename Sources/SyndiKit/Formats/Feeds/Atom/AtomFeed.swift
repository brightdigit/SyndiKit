//
//  AtomFeed.swift
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
/// An XML-based Web content and metadata syndication format.
///
/// Based on the
/// [specifications here](https://datatracker.ietf.org/doc/html/rfc4287#section-4.1.2).
/// - SeeAlso: ``EntryCategory``
public struct AtomFeed: Sendable {
  public enum CodingKeys: String, CodingKey {
    case id
    case title
    case description
    case subtitle
    case published
    case pubDate
    case links = "link"
    case entries = "entry"
    case authors = "author"
    case youtubeChannelID = "yt:channelId"
  }

  /// Identifies the feed using a universally unique and permanent URI.
  /// If you have a long-term, renewable lease on your Internet domain name,
  /// then you can feel free to use your website's address.
  public let id: String

  /// Contains a human readable title for the feed.
  /// Often the same as the title of the associated website.
  public let title: String

  /// Contains a human-readable description or subtitle for the feed.
  public let description: String?

  /// Contains a human-readable description or subtitle for the feed.
  public let subtitle: String?

  /// The publication date for the content in the channel.
  public let published: Date?

  /// The publication date for the content in the channel.
  public let pubDate: Date?

  /// A reference from an entry or feed to a Web resource.
  public let links: [Link]

  /// Individual entries of the feed.
  public let entries: [AtomEntry]

  /// The author of the feed.
  public let authors: [Author]

  /// YouTube channel ID, if from a YouTube channel.
  public let youtubeChannelID: String?
}

extension AtomFeed: DecodableFeed {
  /// The source of the decoder for AtomFeed.
  internal static let source: DecoderSetup = DecoderSource.xml

  /// The label for AtomFeed.
  internal static let label: String = "Atom"

  /// The summary of the AtomFeed.
  public var summary: String? {
    description ?? subtitle
  }

  /// The children of the AtomFeed.
  public var children: [Entryable] {
    entries
  }

  /// The site URL of the AtomFeed.
  public var siteURL: URL? {
    links.first { $0.rel != "self" }?.href
  }

  /// The updated date of the AtomFeed.
  public var updated: Date? {
    pubDate ?? published
  }

  /// The copyright of the AtomFeed.
  public var copyright: String? {
    nil
  }

  /// The image URL of the AtomFeed.
  public var image: URL? {
    nil
  }

  /// The syndication update of the AtomFeed.
  public var syndication: SyndicationUpdate? {
    nil
  }
}

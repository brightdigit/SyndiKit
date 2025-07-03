//
//  RSSFeed.swift
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

#if swift(<6.1)
  import Foundation
#else
  public import Foundation
#endif

/// A struct representing an Atom category.
/// RSS is a Web content syndication format.
///
/// Its name is an acronym for Really Simple Syndication.
/// RSS is dialect of XML.
/// All RSS files must conform to the XML 1.0 specification,
/// as published on the World Wide Web Consortium (W3C) website.
/// At the top level, a RSS document is a <rss> element,
/// with a mandatory attribute called version,
/// that specifies the version of RSS that the document conforms to.
/// If it conforms to this specification,
/// the version attribute must be 2.0.
/// For more details, check out the
/// [W3 sepcifications.](https://validator.w3.org/feed/docs/rss2.html)
/// - SeeAlso: ``EntryCategory``
public struct RSSFeed: Sendable {
  /// Root Channel of hte RSS Feed
  public let channel: RSSChannel
}

extension RSSFeed: DecodableFeed {
  internal static let source: any DecoderSetup = DecoderSource.xml
  /// The label identifying this feed type as "RSS".
  public static let label: String = "RSS"

  /// The YouTube channel ID associated with this feed, if any.
  public var youtubeChannelID: String? {
    nil
  }

  /// The authors of this feed, derived from the channel author.
  public var authors: [Author] {
    guard let author = channel.author else {
      return []
    }
    return [author]
  }

  /// The child entries of this feed, which are the RSS items.
  public var children: [any Entryable] {
    channel.items
  }

  /// The title of this feed, derived from the channel title.
  public var title: String {
    channel.title
  }

  /// The site URL of this feed, derived from the channel link.
  public var siteURL: URL? {
    channel.link
  }

  /// The summary of this feed, derived from the channel description.
  public var summary: String? {
    channel.description
  }

  /// The last updated date of this feed, derived from the channel last build date.
  public var updated: Date? {
    channel.lastBuildDate
  }

  /// The copyright information for this feed, derived from the channel copyright.
  public var copyright: String? {
    channel.copyright
  }

  /// The image URL of this feed, derived from the channel image link.
  public var image: URL? {
    channel.image?.link
  }

  /// The syndication update information for this feed, derived from the channel
  /// syndication.
  public var syndication: SyndicationUpdate? {
    channel.syndication
  }
}

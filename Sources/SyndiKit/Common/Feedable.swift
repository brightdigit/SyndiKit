//
//  Feedable.swift
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

#if swift(>=6.1)
  public import Foundation
#else
  import Foundation
#endif

/// Basic abstract Feed
/// ## Topics
///
/// ### Basic Properties
///
/// - ``title``
/// - ``siteURL``
/// - ``summary``
/// - ``updated``
/// - ``authors``
/// - ``copyright``
/// - ``image``
/// - ``children``
///
/// ### Special Properties
///
/// - ``youtubeChannelID``
/// - ``syndication``
public protocol Feedable: Sendable {
  /// The name of the channel.
  var title: String { get }
  /// The URL to the website corresponding to the channel.
  var siteURL: URL? { get }
  /// Phrase or sentence describing the channel.
  var summary: String? { get }

  /// The last time the content of the channel changed.
  var updated: Date? { get }

  /// The author of the channel.
  var authors: [Author] { get }

  /// Copyright notice for content in the channel.
  var copyright: String? { get }

  /// Specifies a GIF, JPEG or PNG image that can be displayed with the channel.
  var image: URL? { get }

  /// Items or stories attached to the feed.
  var children: [Entryable] { get }

  /// For YouTube channels, this will be the youtube channel ID.
  var youtubeChannelID: String? { get }

  /// Provides syndication hints to aggregators and others
  var syndication: SyndicationUpdate? { get }
}

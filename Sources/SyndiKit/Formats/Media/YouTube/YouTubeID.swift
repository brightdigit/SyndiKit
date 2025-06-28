//
//  YouTubeID.swift
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

/// A struct representing an Atom category.
/// A struct representing the properties of a YouTube ID.
///
/// - Note: This struct conforms to the ``YouTubeID`` protocol.
///
/// - SeeAlso: ``YouTubeID``
///
/// - Important: This struct is internal.
///
/// - Parameters:
///   - videoID: The YouTube video ID.
///   - channelID: The YouTube channel ID.
/// - SeeAlso: ``EntryCategory``
internal struct YouTubeIDProperties: YouTubeID, Sendable {
  internal let videoID: String
  internal let channelID: String

  /// A struct representing an Atom category.
  ///    Initializes a ``YouTubeIDProperties`` instance with the given AtomEntry.
  ///
  ///   - Parameters:
  ///     - entry: The AtomEntry containing the YouTube ID properties.
  ///
  ///   - Returns: A new ``YouTubeIDProperties`` instance,
  ///   or ``nil`` if the required properties are missing.
  /// - SeeAlso: ``EntryCategory``
  internal init?(entry: AtomEntry) {
    guard
      let channelID = entry.youtubeChannelID,
      let videoID = entry.youtubeVideoID
    else {
      return nil
    }
    self.channelID = channelID
    self.videoID = videoID
  }
}

/// A struct representing an Atom category.
/// A protocol abstracting the ID properties of a YouTube RSS Feed.
///
/// - Note: This protocol is public.
///
/// - SeeAlso: ``YouTubeIDProperties``
///
/// - Important: This protocol is specific to YouTube.
///
/// - Requires: Conforming types must provide a ``videoID`` and a ``channelID``.
/// - SeeAlso: ``EntryCategory``
public protocol YouTubeID: Sendable {
  /// The YouTube video ID.
  var videoID: String { get }

  /// The YouTube channel ID.
  var channelID: String { get }
}

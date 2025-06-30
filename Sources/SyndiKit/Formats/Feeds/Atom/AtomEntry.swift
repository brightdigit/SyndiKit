//
//  AtomEntry.swift
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
#else
  import Foundation
#endif

/// A struct representing an entry in an Atom feed.
public struct AtomEntry: Codable, Sendable {
  /// The coding keys used for encoding and decoding.
  public enum CodingKeys: String, CodingKey {
    case id
    case title
    case published
    case content
    case updated
    case links = "link"
    case authors = "author"
    case atomCategories = "category"
    case youtubeVideoID = "yt:videoId"
    case youtubeChannelID = "yt:channelId"
    case creators = "dc:creator"
    case mediaGroup = "media:group"
  }

  /// A permanent, universally unique identifier for an entry.
  public let id: EntryID

  /// A human-readable title for the entry.
  public let title: String

  /// The most recent instant in time when the entry was published.
  public let published: Date?

  /// The content of the entry.
  public let content: String?

  /// The most recent instant in time when the entry was modified.
  public let updated: Date

  /// The categories associated with the entry.
  public let atomCategories: [AtomCategory]

  /// The links associated with the entry.
  public let links: [Link]

  /// The authors of the entry.
  public let authors: [Author]

  /// The YouTube video ID, if the entry is from a YouTube channel.
  public let youtubeVideoID: String?

  /// The YouTube channel ID, if the entry is from a YouTube channel.
  public let youtubeChannelID: String?

  /// The creators of the entry.
  public let creators: [String]

  /// The media group associated with the entry.
  public let mediaGroup: AtomMediaGroup?
}

extension AtomEntry: Entryable {
  /// The categories associated with the entry.
  public var categories: [EntryCategory] {
    atomCategories
  }

  /// The URL of the entry.
  public var url: URL? {
    links.first?.href
  }

  /// The HTML content of the entry.
  public var contentHtml: String? {
    content?.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  /// The summary of the entry.
  public var summary: String? {
    nil
  }

  /// The media content of the entry.
  public var media: MediaContent? {
    YouTubeIDProperties(entry: self).map(Video.youtube).map(MediaContent.video)
  }

  /// The URL of the entry's image.
  public var imageURL: URL? {
    mediaGroup?.thumbnails.first?.url
  }
}

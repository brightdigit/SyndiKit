//
//  RSSChannel.swift
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
/// A struct representing information about the channel (metadata) and its contents.
///
/// - Note: This struct conforms to the ``Codable`` protocol.
///
/// - Remark: The ``CodingKeys`` enum is used to specify the coding keys for the struct.
///
/// - SeeAlso: ``RSSItem``
/// - SeeAlso: ``RSSImage``
/// - SeeAlso: ``Author``
/// - SeeAlso: ``WordPressElements.Category``
/// - SeeAlso: ``WordPressElements.Tag``
/// - SeeAlso: ``iTunesOwner``
/// - SeeAlso: ``PodcastLocked``
/// - SeeAlso: ``PodcastFunding``
/// - SeeAlso: ``PodcastPerson``
/// - SeeAlso: ``EntryCategory``
public struct RSSChannel: Codable, Sendable {
  internal enum CodingKeys: String, CodingKey {
    case title
    case link
    case description
    case lastBuildDate
    case pubDate
    case ttl
    case syUpdatePeriod = "sy:updatePeriod"
    case syUpdateFrequency = "sy:updateFrequency"
    case items = "item"
    case itunesAuthor = "itunes:author"
    case itunesImage = "itunes:image"
    case itunesOwner = "itunes:owner"
    case copyright
    case image
    case author
    case wpCategories = "wp:category"
    case wpTags = "wp:tag"
    case wpBaseSiteURL = "wp:baseSiteUrl"
    case wpBaseBlogURL = "wp:baseBlogUrl"
    case podcastLocked = "podcast:locked"
    case podcastFundings = "podcast:funding"
    case podcastPeople = "podcast:person"
  }

  /// The name of the channel.
  public let title: String

  /// The URL to the HTML website corresponding to the channel.
  public let link: URL

  /// Phrase or sentence describing the channel.
  public let description: String?

  /// The last time the content of the channel changed.
  public let lastBuildDate: Date?

  /// Indicates the publication date and time of the feed's content.
  public let pubDate: Date?

  /// TTL stands for time to live.
  /// It's a number of minutes that indicates
  /// how long a channel can be cached before refreshing from the source.
  public let ttl: Int?

  /// Describes the period over which the channel format is updated.
  public let syUpdatePeriod: SyndicationUpdatePeriod?

  /// Used to describe the frequency of updates in relation to the update period.
  /// A positive integer indicates how many times in that period the channel is updated.
  public let syUpdateFrequency: SyndicationUpdateFrequency?

  /// The items contained in the channel.
  public let items: [RSSItem]

  /// The author of the channel.
  public let itunesAuthor: String?

  /// The image associated with the channel.
  public let itunesImage: String?

  /// The owner of the channel.
  public let itunesOwner: iTunesOwner?

  /// Copyright notice for content in the channel.
  public let copyright: String?

  /// Specifies a GIF, JPEG or PNG image that can be displayed with the channel.
  public let image: RSSImage?

  /// The author of the channel.
  public let author: Author?

  /// The categories associated with the channel.
  public let wpCategories: [WordPressElements.Category]

  /// The tags associated with the channel.
  public let wpTags: [WordPressElements.Tag]

  /// The base site URL of the channel.
  public let wpBaseSiteURL: URL?

  /// The base blog URL of the channel.
  public let wpBaseBlogURL: URL?

  /// Indicates whether the podcast is locked.
  public let podcastLocked: PodcastLocked?

  /// The fundings associated with the podcast.
  public let podcastFundings: [PodcastFunding]

  /// The people associated with the podcast.
  public let podcastPeople: [PodcastPerson]
}

extension RSSChannel {
  /// A struct representing an Atom category.
  ///   A computed property that returns a ``SyndicationUpdate`` object
  ///   based on the ``syUpdatePeriod`` and ``syUpdateFrequency`` properties.
  ///
  ///   - Returns: A ``SyndicationUpdate`` object.
  /// - SeeAlso: ``EntryCategory``
  public var syndication: SyndicationUpdate? {
    SyndicationUpdate(
      period: syUpdatePeriod,
      frequency: syUpdateFrequency?.value
    )
  }
}

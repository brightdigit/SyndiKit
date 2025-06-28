//
//  PodcastEpisode.swift
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

/// A struct representing properties of a podcast episode.
internal struct PodcastEpisodeProperties: PodcastEpisode, Sendable {
  /// The title of the episode.
  internal let title: String?

  /// The episode number.
  internal let episode: Int?

  /// The author of the episode.
  internal let author: String?

  /// The subtitle of the episode.
  internal let subtitle: String?

  /// A summary of the episode.
  internal let summary: String?

  /// Indicates if the episode contains explicit content.
  internal let explicit: String?

  /// The duration of the episode.
  internal let duration: TimeInterval?

  /// The image associated with the episode.
  internal let image: iTunesImage?

  /// The enclosure of the episode.
  internal let enclosure: Enclosure

  /// The people involved in the episode.
  internal let people: [PodcastPerson]

  /// A struct representing an Atom category.
  ///   Initializes a ``PodcastEpisodeProperties`` instance from an ``RSSItem``.
  ///
  ///   - Parameter rssItem: The ``RSSItem`` to extract the properties from.
  ///
  ///   - Returns: An initialized ``PodcastEpisodeProperties`` instance,
  ///   or ``nil`` if the ``enclosure`` property is missing.
  /// - SeeAlso: ``EntryCategory``
  internal init?(rssItem: RSSItem) {
    guard let enclosure = rssItem.enclosure else {
      return nil
    }
    title = rssItem.itunesTitle
    episode = rssItem.itunesEpisode?.value
    author = rssItem.itunesAuthor
    subtitle = rssItem.itunesSubtitle
    summary = rssItem.itunesSummary?.value
    explicit = rssItem.itunesExplicit
    duration = rssItem.itunesDuration?.value
    image = rssItem.itunesImage
    self.enclosure = enclosure
    people = rssItem.podcastPeople
  }
}

/// A protocol representing a podcast episode.
public protocol PodcastEpisode: Sendable {
  /// The title of the episode.
  var title: String? { get }

  /// The episode number.
  var episode: Int? { get }

  /// The author of the episode.
  var author: String? { get }

  /// The subtitle of the episode.
  var subtitle: String? { get }

  /// A summary of the episode.
  var summary: String? { get }

  /// Indicates if the episode contains explicit content.
  var explicit: String? { get }

  /// The duration of the episode.
  var duration: TimeInterval? { get }

  /// The image associated with the episode.
  var image: iTunesImage? { get }

  /// The enclosure of the episode.
  var enclosure: Enclosure { get }

  /// The people involved in the episode.
  var people: [PodcastPerson] { get }
}

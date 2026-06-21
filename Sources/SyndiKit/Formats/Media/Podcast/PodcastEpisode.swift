//
//  PodcastEpisode.swift
//  SyndiKit
//
//  Created by Leo Dion.
//  Copyright © 2026 BrightDigit.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#if swift(<6.0)
  import Foundation
#else
  public import Foundation
#endif

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

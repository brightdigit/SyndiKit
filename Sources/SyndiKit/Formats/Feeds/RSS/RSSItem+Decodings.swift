//
//  RSSItem+Decodings.swift
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
import XMLCoder

extension RSSItem {
  // swiftlint:disable function_body_length
  /// A struct representing an Atom category.
  ///   Initializes a new ``RSSItem`` by decoding data from a decoder.
  ///
  ///   - Parameter decoder: The decoder to read data from.
  ///
  ///   - Throws: An error if the decoding fails.
  /// - SeeAlso: ``EntryCategory``
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decode(String.self, forKey: .title)
    link = try container.decodeIfPresent(URL.self, forKey: .link)
    description = try container.decodeIfPresent(CData.self, forKey: .description)
    guid = try container.decode(EntryID.self, forKey: .guid)
    pubDate = try container.decodeDateIfPresentAndValid(forKey: .pubDate)
    contentEncoded = try container.decodeIfPresent(CData.self, forKey: .contentEncoded)
    categoryTerms = try container.decode([RSSItemCategory].self, forKey: .categoryTerms)
    content = try container.decodeIfPresent(String.self, forKey: .content)
    itunesTitle = try container.decodeIfPresent(String.self, forKey: .itunesTitle)
    itunesEpisode = try container.decodeIfPresent(
      iTunesEpisode.self, forKey: .itunesEpisode
    )
    itunesAuthor = try container.decodeIfPresent(String.self, forKey: .itunesAuthor)
    itunesSubtitle = try container.decodeIfPresent(String.self, forKey: .itunesSubtitle)
    itunesSummary = try container.decodeIfPresent(CData.self, forKey: .itunesSummary)
    itunesExplicit = try container.decodeIfPresent(String.self, forKey: .itunesExplicit)
    itunesDuration = try container.decodeIfPresent(
      iTunesDuration.self, forKey: .itunesDuration
    )
    itunesImage = try container.decodeIfPresent(iTunesImage.self, forKey: .itunesImage)

    podcastPeople =
      try container.decodeIfPresent(
        [PodcastPerson].self,
        forKey: .podcastPeople
      ) ?? []
    podcastTranscripts =
      try container.decodeIfPresent(
        [PodcastTranscript].self,
        forKey: .podcastTranscripts
      ) ?? []
    podcastChapters = try container.decodeIfPresent(
      PodcastChapters.self,
      forKey: .podcastChapters
    )
    podcastSoundbites =
      try container.decodeIfPresent(
        [PodcastSoundbite].self,
        forKey: .podcastSoundbites
      ) ?? []

    podcastSeason = try container.decodeIfPresent(
      PodcastSeason.self,
      forKey: .podcastSeason
    )

    enclosure = try container.decodeIfPresent(Enclosure.self, forKey: .enclosure)
    creators = try container.decode([String].self, forKey: .creators)

    mediaContent =
      try container.decodeIfPresent(AtomMedia.self, forKey: .mediaContent)
    mediaThumbnail =
      try container.decodeIfPresent(AtomMedia.self, forKey: .mediaThumbnail)

    wpPostID = try container.decodeIfPresent(Int.self, forKey: .wpPostID)
    wpPostDate = try container.decodeIfPresent(Date.self, forKey: .wpPostDate)
    let wpPostDateGMT = try container.decodeIfPresent(
      String.self, forKey: .wpPostDateGMT
    )
    if let wpPostDateGMT = wpPostDateGMT {
      if wpPostDateGMT == "0000-00-00 00:00:00" {
        self.wpPostDateGMT = nil
      } else {
        self.wpPostDateGMT = try container.decode(
          Date.self, forKey: .wpPostDateGMT
        )
      }
    } else {
      self.wpPostDateGMT = nil
    }

    wpModifiedDate = try container.decodeIfPresent(
      Date.self, forKey: .wpModifiedDate
    )

    let wpModifiedDateGMT = try container.decodeIfPresent(
      String.self, forKey: .wpModifiedDateGMT
    )
    if let wpModifiedDateGMT = wpModifiedDateGMT {
      if wpModifiedDateGMT == "0000-00-00 00:00:00" {
        self.wpModifiedDateGMT = nil
      } else {
        self.wpModifiedDateGMT = try container.decode(
          Date.self, forKey: .wpModifiedDateGMT
        )
      }
    } else {
      self.wpModifiedDateGMT = nil
    }

    let wpAttachmentURLCDData = try container.decodeIfPresent(
      CData.self,
      forKey: .wpAttachmentURL
    )
    wpAttachmentURL = wpAttachmentURLCDData.map { $0.value }.flatMap(URL.init(string:))

    wpPostName = try container.decodeIfPresent(CData.self, forKey: .wpPostName)
    wpPostType = try container.decodeIfPresent(CData.self, forKey: .wpPostType)
    wpPostMeta =
      try container.decodeIfPresent(
        [WordPressElements.PostMeta].self,
        forKey: .wpPostMeta
      ) ?? []
    wpCommentStatus = try container.decodeIfPresent(CData.self, forKey: .wpCommentStatus)
    wpPingStatus = try container.decodeIfPresent(CData.self, forKey: .wpPingStatus)
    wpStatus = try container.decodeIfPresent(CData.self, forKey: .wpStatus)
    wpPostParent = try container.decodeIfPresent(Int.self, forKey: .wpPostParent)
    wpMenuOrder = try container.decodeIfPresent(Int.self, forKey: .wpMenuOrder)
    wpIsSticky = try container.decodeIfPresent(Int.self, forKey: .wpIsSticky)
    wpPostPassword = try container.decodeIfPresent(
      CData.self, forKey: .wpPostPassword
    )
  }

  // swiftlint:enable function_body_length
}

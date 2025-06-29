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

// New imports for the refactored types
// (Assuming these are in the same module, otherwise use @testable import SyndiKit)

extension RSSItem {
  /// A struct representing an Atom category.
  ///   Initializes a new ``RSSItem`` by decoding data from a decoder.
  ///
  ///   - Parameter decoder: The decoder to read data from.
  ///
  ///   - Throws: An error if the decoding fails.
  /// - SeeAlso: ``EntryCategory``
  public init(from decoder: Decoder) throws {
    self = try RSSItem.decodeFromContainer(
      try decoder.container(keyedBy: CodingKeys.self)
    )
  }

  // MARK: - Private Helper Methods

  private static func decodeFromContainer(
    _ container: KeyedDecodingContainer<CodingKeys>
  ) throws -> RSSItem {
    let basicProps = try BasicProperties(from: container)
    let iTunesProps = try ITunesProperties(from: container)
    let podcastProps = try PodcastProperties(from: container)
    let mediaProps = try MediaProperties(from: container)
    let wpProps = try WordPressProperties(from: container)

    return createRSSItem(
      basicFields: basicFields,
      itunesFields: itunesFields,
      podcastFields: podcastFields,
      wordpressFields: wordpressFields,
      mediaFields: mediaFields
    )
  }

  private static func createRSSItem(
    basicFields: BasicFields,
    itunesFields: ITunesFields,
    podcastFields: PodcastFields,
    wordpressFields: WordPressFields,
    mediaFields: MediaFields
  ) -> RSSItem {
    let basicProps = createBasicRSSItemProperties(basicFields: basicFields)
    let itunesProps = createITunesRSSItemProperties(itunesFields: itunesFields)
    let podcastProps = createPodcastRSSItemProperties(podcastFields: podcastFields)
    let wordpressProps = createWordPressRSSItemProperties(wordpressFields: wordpressFields)
    let mediaProps = createMediaRSSItemProperties(mediaFields: mediaFields)

    let basicRSSProps = createBasicRSSProperties(basicProps: basicProps)
    let itunesRSSProps = createITunesRSSProperties(itunesProps: itunesProps)
    let podcastRSSProps = createPodcastRSSProperties(podcastProps: podcastProps)
    let wordpressRSSProps = createWordPressRSSProperties(wordpressProps: wordpressProps)
    let mediaRSSProps = createMediaRSSProperties(mediaProps: mediaProps)

    let basicRSSParams = createBasicRSSParameters(basicRSSProps: basicRSSProps)
    let itunesRSSParams = createITunesRSSParameters(itunesRSSProps: itunesRSSProps)
    let podcastRSSParams = createPodcastRSSParameters(podcastRSSProps: podcastRSSProps)
    let wordpressRSSParams = createWordPressRSSParameters(wordpressRSSProps: wordpressRSSProps)
    let mediaRSSParams = createMediaRSSParameters(mediaRSSProps: mediaRSSProps)

    return RSSItem(
      basicProperties: basicProps,
      itunesProperties: iTunesProps,
      podcastProperties: podcastProps,
      wordpressProperties: wpProps,
      mediaProperties: mediaProps
    )
  }

  /// Initializes a new RSSItem with the specified property sets.
  ///
  /// - Parameters:
  ///   - basicProperties: The basic RSS item properties.
  ///   - itunesProperties: The iTunes-specific properties.
  ///   - podcastProperties: The podcast-specific properties.
  ///   - wordpressProperties: The WordPress-specific properties.
  ///   - mediaProperties: The media-specific properties.
  internal init(
    basicProperties: BasicProperties,
    itunesProperties: ITunesProperties,
    podcastProperties: PodcastProperties,
    wordpressProperties: WordPressProperties,
    mediaProperties: MediaProperties
  ) {
    self.init(
      title: basicProperties.title,
      link: basicProperties.link,
      description: basicProperties.description?.value,
      guid: basicProperties.guid,
      pubDate: basicProperties.pubDate,
      contentEncoded: basicProperties.contentEncoded?.value,
      categoryTerms: basicProperties.categoryTerms,
      content: basicProperties.content,
      itunesTitle: itunesProperties.title,
      itunesEpisode: itunesProperties.episode?.value,
      itunesAuthor: itunesProperties.author,
      itunesSubtitle: itunesProperties.subtitle,
      itunesSummary: itunesProperties.summary,
      itunesExplicit: itunesProperties.explicit,
      itunesDuration: itunesProperties.duration?.value,
      itunesImage: itunesProperties.image,
      podcastPeople: podcastProperties.people,
      podcastTranscripts: podcastProperties.transcripts,
      podcastChapters: podcastProperties.chapters,
      podcastSoundbites: podcastProperties.soundbites,
      podcastSeason: podcastProperties.season,
      enclosure: basicProperties.enclosure,
      creators: basicProperties.creators,
      wpCommentStatus: wordpressProperties.commentStatus?.value,
      wpPingStatus: wordpressProperties.pingStatus?.value,
      wpStatus: wordpressProperties.status?.value,
      wpPostParent: wordpressProperties.postParent,
      wpMenuOrder: wordpressProperties.menuOrder,
      wpIsSticky: wordpressProperties.isSticky,
      wpPostPassword: wordpressProperties.postPassword?.value,
      wpPostID: wordpressProperties.postID,
      wpPostDate: wordpressProperties.postDate,
      wpPostDateGMT: wordpressProperties.postDateGMT,
      wpModifiedDate: wordpressProperties.modifiedDate,
      wpModifiedDateGMT: wordpressProperties.modifiedDateGMT,
      wpPostName: wordpressProperties.postName?.value,
      wpPostType: wordpressProperties.postType?.value,
      wpPostMeta: wordpressProperties.postMeta,
      wpAttachmentURL: wordpressProperties.attachmentURL,
      mediaContent: mediaProperties.content,
      mediaThumbnail: mediaProperties.thumbnail
    )
  }
}

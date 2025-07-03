//
//  RSSItem+InternalInit.swift
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

import XMLCoder

#if swift(<5.7)
  import Foundation
#elseif swift(<6.1)
  import Foundation
#else
  internal import Foundation
#endif

extension RSSItem {
  // swiftlint:disable function_body_length
  /// Initializes a new ``RSSItem`` instance with property sets.
  ///
  /// - Parameters:
  ///   - title: The title of the RSS item.
  ///   - link: The URL link of the RSS item.
  ///   - description: The description of the RSS item.
  ///   - guid: The globally unique identifier of the RSS item.
  ///   - pubDate: The publication date of the RSS item.
  ///   - contentEncoded: The encoded content of the RSS item.
  ///   - categoryTerms: The category terms of the RSS item.
  ///   - content: The content of the RSS item.
  ///   - itunes: The iTunes properties of the RSS item.
  ///   - podcast: The podcast properties of the RSS item.
  ///   - enclosure: The enclosure of the RSS item.
  ///   - creators: The creators of the RSS item.
  ///   - wordPress: The WordPress properties of the RSS item.
  ///   - mediaContent: The media content of the RSS item.
  ///   - mediaThumbnail: The media thumbnail of the RSS item.
  /// - SeeAlso: ``EntryCategory``
  internal init(
    title: String,
    link: URL?,
    description: String?,
    guid: EntryID,
    pubDate: Date? = nil,
    contentEncoded: String? = nil,
    categoryTerms: [RSSItemCategory] = [],
    content: String? = nil,
    itunes: ITunesProperties,
    podcast: PodcastProperties,
    enclosure: Enclosure? = nil,
    creators: [String] = [],
    wordPress: WordPressProperties,
    mediaContent: AtomMedia? = nil,
    mediaThumbnail: AtomMedia? = nil
  ) {
    self.title = title
    self.link = link
    self.description = description.map(CData.init)
    self.guid = guid
    self.pubDate = pubDate
    self.contentEncoded = contentEncoded.map(CData.init)
    self.categoryTerms = categoryTerms
    self.content = content

    self.itunesTitle = itunes.title
    self.itunesEpisode = itunes.episode
    self.itunesAuthor = itunes.author
    self.itunesSubtitle = itunes.subtitle
    self.itunesSummary = itunes.summary
    self.itunesExplicit = itunes.explicit
    self.itunesDuration = itunes.duration
    self.itunesImage = itunes.image

    self.podcastPeople = podcast.people
    self.podcastTranscripts = podcast.transcripts
    self.podcastChapters = podcast.chapters
    self.podcastSoundbites = podcast.soundbites
    self.podcastSeason = podcast.season

    self.enclosure = enclosure
    self.creators = creators

    self.wpCommentStatus = wordPress.commentStatus
    self.wpPingStatus = wordPress.pingStatus
    self.wpStatus = wordPress.status
    self.wpPostParent = wordPress.postParent
    self.wpMenuOrder = wordPress.menuOrder
    self.wpIsSticky = wordPress.isSticky
    self.wpPostPassword = wordPress.postPassword
    self.wpPostID = wordPress.postID
    self.wpPostDate = wordPress.postDate
    self.wpPostDateGMT = wordPress.postDateGMT
    self.wpModifiedDate = wordPress.modifiedDate
    self.wpModifiedDateGMT = wordPress.modifiedDateGMT
    self.wpPostName = wordPress.postName
    self.wpPostType = wordPress.postType
    self.wpPostMeta = wordPress.postMeta
    self.wpAttachmentURL = wordPress.attachmentURL
    self.mediaContent = mediaContent
    self.mediaThumbnail = mediaThumbnail
  }
  // swiftlint:enable function_body_length
}

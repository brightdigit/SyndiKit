//
//  RSSItem.swift
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
  @preconcurrency import Foundation
#elseif swift(<6.0)
  import Foundation
#else
  public import Foundation
#endif

/// A struct representing an RSS item/entry.
/// RSS items contain the individual pieces of content within an RSS feed,
/// including title, link, description, publication date, and various media attachments.
public struct RSSItem: Codable, Sendable {
  /// Coding keys for encoding and decoding RSS item elements.
  public enum CodingKeys: String, CodingKey {
    case title
    case link
    case description
    case guid
    case pubDate
    case categoryTerms = "category"
    case enclosure
    case contentEncoded = "content:encoded"
    case content
    case itunesTitle = "itunes:title"
    case itunesEpisode = "itunes:episode"
    case itunesAuthor = "itunes:author"
    case itunesSubtitle = "itunes:subtitle"
    case itunesSummary = "itunes:summary"
    case itunesExplicit = "itunes:explicit"
    case podcastPeople = "podcast:person"
    case podcastTranscripts = "podcast:transcript"
    case podcastChapters = "podcast:chapters"
    case podcastSoundbites = "podcast:soundbite"
    case podcastSeason = "podcast:season"
    case itunesDuration = "itunes:duration"
    case itunesImage = "itunes:image"
    case creators = "dc:creator"

    case wpPostID = "wp:postId"
    case wpPostDate = "wp:postDate"
    case wpPostDateGMT = "wp:postDateGmt"
    case wpModifiedDate = "wp:postModified"
    case wpModifiedDateGMT = "wp:postModifiedGmt"
    case wpPostName = "wp:postName"
    case wpPostType = "wp:postType"
    case wpPostMeta = "wp:postmeta"
    case wpCommentStatus = "wp:commentStatus"
    case wpPingStatus = "wp:pingStatus"
    case wpAttachmentURL = "wp:attachmentUrl"

    case wpStatus = "wp:status"
    case wpPostParent = "wp:postParent"
    case wpMenuOrder = "wp:menuOrder"
    case wpIsSticky = "wp:isSticky"
    case wpPostPassword = "wp:postPassword"

    case mediaContent = "media:content"
    case mediaThumbnail = "media:thumbnail"
  }

  /// The title of the RSS item.
  public let title: String
  /// The URL of the RSS item.
  public let link: URL?
  /// The description of the RSS item.
  public let description: CData?
  /// A unique identifier for the RSS item.
  public let guid: EntryID
  /// The publication date of the RSS item.
  public let pubDate: Date?
  /// The encoded content of the RSS item using the content:encoded element.
  public let contentEncoded: CData?
  /// The categories associated with the RSS item.
  public let categoryTerms: [RSSItemCategory]
  /// The content of the RSS item.
  public let content: String?
  /// The iTunes-specific title for the RSS item.
  public let itunesTitle: String?
  /// The iTunes episode number information.
  public let itunesEpisode: iTunesEpisode?
  /// The iTunes author of the RSS item.
  public let itunesAuthor: String?
  /// The iTunes subtitle for the RSS item.
  public let itunesSubtitle: String?
  /// The iTunes summary of the RSS item.
  public let itunesSummary: CData?
  /// The iTunes explicit content indicator.
  public let itunesExplicit: String?
  /// The iTunes duration of the media content.
  public let itunesDuration: iTunesDuration?
  /// The iTunes image for the RSS item.
  public let itunesImage: iTunesImage?
  /// The people associated with this podcast episode.
  public let podcastPeople: [PodcastPerson]
  /// The transcripts available for this podcast episode.
  public let podcastTranscripts: [PodcastTranscript]
  /// The chapters information for this podcast episode.
  public let podcastChapters: PodcastChapters?
  /// The soundbites for this podcast episode.
  public let podcastSoundbites: [PodcastSoundbite]
  /// The season information for this podcast episode.
  public let podcastSeason: PodcastSeason?
  /// The media enclosure for the RSS item.
  public let enclosure: Enclosure?
  /// The Dublin Core creators of the RSS item.
  public let creators: [String]
  /// The WordPress comment status for the post.
  public let wpCommentStatus: CData?
  /// The WordPress ping status for the post.
  public let wpPingStatus: CData?
  /// The WordPress post status.
  public let wpStatus: CData?
  /// The WordPress parent post ID.
  public let wpPostParent: Int?
  /// The WordPress menu order.
  public let wpMenuOrder: Int?
  /// Whether the WordPress post is sticky.
  public let wpIsSticky: Int?
  /// The WordPress post password.
  public let wpPostPassword: CData?
  /// The WordPress post ID.
  public let wpPostID: Int?
  /// The WordPress post creation date in local timezone.
  public let wpPostDate: Date?
  /// The WordPress post creation date in GMT.
  public let wpPostDateGMT: Date?
  /// The WordPress post modification date in local timezone.
  public let wpModifiedDate: Date?
  /// The WordPress post modification date in GMT.
  public let wpModifiedDateGMT: Date?
  /// The WordPress post slug/name.
  public let wpPostName: CData?
  /// The WordPress post type.
  public let wpPostType: CData?
  /// The WordPress post metadata.
  public let wpPostMeta: [WordPressElements.PostMeta]
  /// The WordPress attachment URL.
  public let wpAttachmentURL: URL?
  /// The media content element from Media RSS namespace.
  public let mediaContent: AtomMedia?
  /// The media thumbnail element from Media RSS namespace.
  public let mediaThumbnail: AtomMedia?
}

extension RSSItem: Entryable {
  /// The categories associated with this RSS item.
  public var categories: [any EntryCategory] {
    categoryTerms
  }

  /// The URL associated with this RSS item.
  public var url: URL? {
    link
  }

  /// The HTML content of this RSS item.
  public var contentHtml: String? {
    contentEncoded?.value ?? content ?? description?.value
  }

  /// The summary of this RSS item.
  public var summary: String? {
    description?.value
  }

  /// The authors of this RSS item, derived from creators or iTunes author.
  public var authors: [Author] {
    let creatorAuthors = creators.map { Author(name: $0) }
    if !creatorAuthors.isEmpty {
      return creatorAuthors
    }
    return itunesAuthor.map { [Author(name: $0)] } ?? []
  }

  /// The unique identifier for this RSS item.
  public var id: EntryID { guid }

  /// The publication date of this RSS item.
  public var published: Date? { pubDate }

  /// The media content associated with this RSS item.
  public var media: MediaContent? {
    PodcastEpisodeProperties(rssItem: self).map(MediaContent.podcast)
  }

  /// The image URL associated with this RSS item, derived from iTunes image,
  /// media thumbnail, or media content.
  public var imageURL: URL? {
    itunesImage?.href ?? mediaThumbnail?.url ?? mediaContent?.url
  }
}

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

#if swift(>=5.7)
  @preconcurrency import Foundation
#else
  import Foundation
#endif

public struct RSSItem: Codable, Sendable {
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

  public let title: String
  public let link: URL?
  public let description: CData?
  public let guid: EntryID
  public let pubDate: Date?
  public let contentEncoded: CData?
  public let categoryTerms: [RSSItemCategory]
  public let content: String?
  public let itunesTitle: String?
  public let itunesEpisode: iTunesEpisode?
  public let itunesAuthor: String?
  public let itunesSubtitle: String?
  public let itunesSummary: CData?
  public let itunesExplicit: String?
  public let itunesDuration: iTunesDuration?
  public let itunesImage: iTunesImage?
  public let podcastPeople: [PodcastPerson]
  public let podcastTranscripts: [PodcastTranscript]
  public let podcastChapters: PodcastChapters?
  public let podcastSoundbites: [PodcastSoundbite]
  public let podcastSeason: PodcastSeason?
  public let enclosure: Enclosure?
  public let creators: [String]
  public let wpCommentStatus: CData?
  public let wpPingStatus: CData?
  public let wpStatus: CData?
  public let wpPostParent: Int?
  public let wpMenuOrder: Int?
  public let wpIsSticky: Int?
  public let wpPostPassword: CData?
  public let wpPostID: Int?
  public let wpPostDate: Date?
  public let wpPostDateGMT: Date?
  public let wpModifiedDate: Date?
  public let wpModifiedDateGMT: Date?
  public let wpPostName: CData?
  public let wpPostType: CData?
  public let wpPostMeta: [WordPressElements.PostMeta]
  public let wpAttachmentURL: URL?
  public let mediaContent: AtomMedia?
  public let mediaThumbnail: AtomMedia?
}

extension RSSItem: Entryable {
  public var categories: [EntryCategory] {
    categoryTerms
  }

  public var url: URL? {
    link
  }

  public var contentHtml: String? {
    contentEncoded?.value ?? content ?? description?.value
  }

  public var summary: String? {
    description?.value
  }

  public var authors: [Author] {
    let creatorAuthors = creators.map { Author(name: $0) }
    if !creatorAuthors.isEmpty {
      return creatorAuthors
    }
    return itunesAuthor.map { [Author(name: $0)] } ?? []
  }

  public var id: EntryID {
    guid
  }

  public var published: Date? {
    pubDate
  }

  public var media: MediaContent? {
    PodcastEpisodeProperties(rssItem: self).map(MediaContent.podcast)
  }

  public var imageURL: URL? {
    itunesImage?.href ?? mediaThumbnail?.url ?? mediaContent?.url
  }
}

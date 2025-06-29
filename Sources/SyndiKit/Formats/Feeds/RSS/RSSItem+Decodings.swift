//
//  RSSItem+Decodings.swift
//  SyndiKit
//
//  Created by Leo Dion.
//  Copyright © 2025 BrightDigit.
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

import Foundation
import XMLCoder

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
    let basicProps = try decodeBasicProperties(from: container)
    let iTunesProps = try decodeITunesProperties(from: container)
    let podcastProps = try decodePodcastProperties(from: container)
    let mediaProps = try decodeMediaProperties(from: container)
    let wpProps = try decodeWordPressProperties(from: container)
    return makeRSSItem(
      basic: basicProps,
      itunes: iTunesProps,
      podcast: podcastProps,
      media: mediaProps,
      wordpress: wpProps
    )
  }

  private static func makeRSSItem(
    basic: BasicProperties,
    itunes: ITunesProperties,
    podcast: PodcastProperties,
    media: MediaProperties,
    wordpress: WordPressProperties
  ) -> RSSItem {
    let basicFields = makeBasicFields(basic: basic)
    let itunesFields = makeITunesFields(itunes: itunes)
    let podcastFields = makePodcastFields(podcast: podcast)
    let wordpressFields = makeWordPressFields(wordpress: wordpress)
    let mediaFields = makeMediaFields(media: media)

    return RSSItem(
      title: basicFields.title,
      link: basicFields.link,
      description: basicFields.description,
      guid: basicFields.guid,
      pubDate: basicFields.pubDate,
      contentEncoded: basicFields.contentEncoded,
      categoryTerms: basicFields.categoryTerms,
      content: basicFields.content,
      itunesTitle: itunesFields.title,
      itunesEpisode: itunesFields.episode,
      itunesAuthor: itunesFields.author,
      itunesSubtitle: itunesFields.subtitle,
      itunesSummary: itunesFields.summary,
      itunesExplicit: itunesFields.explicit,
      itunesDuration: itunesFields.duration,
      itunesImage: itunesFields.image,
      podcastPeople: podcastFields.people,
      podcastTranscripts: podcastFields.transcripts,
      podcastChapters: podcastFields.chapters,
      podcastSoundbites: podcastFields.soundbites,
      podcastSeason: podcastFields.season,
      enclosure: basicFields.enclosure,
      creators: basicFields.creators,
      wpCommentStatus: wordpressFields.commentStatus,
      wpPingStatus: wordpressFields.pingStatus,
      wpStatus: wordpressFields.status,
      wpPostParent: wordpressFields.postParent,
      wpMenuOrder: wordpressFields.menuOrder,
      wpIsSticky: wordpressFields.isSticky,
      wpPostPassword: wordpressFields.postPassword,
      wpPostID: wordpressFields.postID,
      wpPostDate: wordpressFields.postDate,
      wpPostDateGMT: wordpressFields.postDateGMT,
      wpModifiedDate: wordpressFields.modifiedDate,
      wpModifiedDateGMT: wordpressFields.modifiedDateGMT,
      wpPostName: wordpressFields.postName,
      wpPostType: wordpressFields.postType,
      wpPostMeta: wordpressFields.postMeta,
      wpAttachmentURL: wordpressFields.attachmentURL,
      mediaContent: mediaFields.content,
      mediaThumbnail: mediaFields.thumbnail
    )
  }

  private struct BasicFields {
    let title: String
    let link: URL?
    let description: CData?
    let guid: EntryID
    let pubDate: Date?
    let contentEncoded: CData?
    let categoryTerms: [RSSItemCategory]
    let content: String?
    let enclosure: Enclosure?
    let creators: [String]
  }

  private struct ITunesFields {
    let title: String?
    let episode: iTunesEpisode?
    let author: String?
    let subtitle: String?
    let summary: CData?
    let explicit: String?
    let duration: iTunesDuration?
    let image: iTunesImage?
  }

  private struct PodcastFields {
    let people: [PodcastPerson]
    let transcripts: [PodcastTranscript]
    let chapters: PodcastChapters?
    let soundbites: [PodcastSoundbite]
    let season: PodcastSeason?
  }

  private struct WordPressFields {
    let commentStatus: CData?
    let pingStatus: CData?
    let status: CData?
    let postParent: Int?
    let menuOrder: Int?
    let isSticky: Int?
    let postPassword: CData?
    let postID: Int?
    let postDate: Date?
    let postDateGMT: Date?
    let modifiedDate: Date?
    let modifiedDateGMT: Date?
    let postName: CData?
    let postType: CData?
    let postMeta: [WordPressElements.PostMeta]
    let attachmentURL: URL?
  }

  private struct MediaFields {
    let content: AtomMedia?
    let thumbnail: AtomMedia?
  }

  private static func makeBasicFields(basic: BasicProperties) -> BasicFields {
    BasicFields(
      title: basic.title,
      link: basic.link,
      description: basic.description,
      guid: basic.guid,
      pubDate: basic.pubDate,
      contentEncoded: basic.contentEncoded,
      categoryTerms: basic.categoryTerms,
      content: basic.content,
      enclosure: basic.enclosure,
      creators: basic.creators
    )
  }

  private static func makeITunesFields(itunes: ITunesProperties) -> ITunesFields {
    ITunesFields(
      title: itunes.title,
      episode: itunes.episode,
      author: itunes.author,
      subtitle: itunes.subtitle,
      summary: itunes.summary,
      explicit: itunes.explicit,
      duration: itunes.duration,
      image: itunes.image
    )
  }

  private static func makePodcastFields(podcast: PodcastProperties) -> PodcastFields {
    PodcastFields(
      people: podcast.people,
      transcripts: podcast.transcripts,
      chapters: podcast.chapters,
      soundbites: podcast.soundbites,
      season: podcast.season
    )
  }

  private static func makeWordPressFields(wordpress: WordPressProperties) -> WordPressFields {
    WordPressFields(
      commentStatus: wordpress.commentStatus,
      pingStatus: wordpress.pingStatus,
      status: wordpress.status,
      postParent: wordpress.postParent,
      menuOrder: wordpress.menuOrder,
      isSticky: wordpress.isSticky,
      postPassword: wordpress.postPassword,
      postID: wordpress.postID,
      postDate: wordpress.postDate,
      postDateGMT: wordpress.postDateGMT,
      modifiedDate: wordpress.modifiedDate,
      modifiedDateGMT: wordpress.modifiedDateGMT,
      postName: wordpress.postName,
      postType: wordpress.postType,
      postMeta: wordpress.postMeta,
      attachmentURL: wordpress.attachmentURL
    )
  }

  private static func makeMediaFields(media: MediaProperties) -> MediaFields {
    MediaFields(
      content: media.content,
      thumbnail: media.thumbnail
    )
  }

  private struct BasicProperties {
    let title: String
    let link: URL?
    let description: CData?
    let guid: EntryID
    let pubDate: Date?
    let contentEncoded: CData?
    let categoryTerms: [RSSItemCategory]
    let content: String?
    let enclosure: Enclosure?
    let creators: [String]
  }

  private struct ITunesProperties {
    let title: String?
    let episode: iTunesEpisode?
    let author: String?
    let subtitle: String?
    let summary: CData?
    let explicit: String?
    let duration: iTunesDuration?
    let image: iTunesImage?
  }

  private struct PodcastProperties {
    let people: [PodcastPerson]
    let transcripts: [PodcastTranscript]
    let chapters: PodcastChapters?
    let soundbites: [PodcastSoundbite]
    let season: PodcastSeason?
  }

  private struct MediaProperties {
    let content: AtomMedia?
    let thumbnail: AtomMedia?
  }

  private struct WordPressProperties {
    let postID: Int?
    let postDate: Date?
    let postDateGMT: Date?
    let modifiedDate: Date?
    let modifiedDateGMT: Date?
    let postName: CData?
    let postType: CData?
    let postMeta: [WordPressElements.PostMeta]
    let commentStatus: CData?
    let pingStatus: CData?
    let status: CData?
    let postParent: Int?
    let menuOrder: Int?
    let isSticky: Int?
    let postPassword: CData?
    let attachmentURL: URL?
  }

  private static func decodeBasicProperties(
    from container: KeyedDecodingContainer<CodingKeys>
  ) throws -> BasicProperties {
    BasicProperties(
      title: try container.decode(String.self, forKey: .title),
      link: try container.decodeIfPresent(URL.self, forKey: .link),
      description: try container.decodeIfPresent(CData.self, forKey: .description),
      guid: try container.decode(EntryID.self, forKey: .guid),
      pubDate: try container.decodeDateIfPresentAndValid(forKey: .pubDate),
      contentEncoded: try container.decodeIfPresent(CData.self, forKey: .contentEncoded),
      categoryTerms: try container.decode([RSSItemCategory].self, forKey: .categoryTerms),
      content: try container.decodeIfPresent(String.self, forKey: .content),
      enclosure: try container.decodeIfPresent(Enclosure.self, forKey: .enclosure),
      creators: try container.decode([String].self, forKey: .creators)
    )
  }

  private static func decodeITunesProperties(
    from container: KeyedDecodingContainer<CodingKeys>
  ) throws -> ITunesProperties {
    ITunesProperties(
      title: try container.decodeIfPresent(String.self, forKey: .itunesTitle),
      episode: try container.decodeIfPresent(iTunesEpisode.self, forKey: .itunesEpisode),
      author: try container.decodeIfPresent(String.self, forKey: .itunesAuthor),
      subtitle: try container.decodeIfPresent(String.self, forKey: .itunesSubtitle),
      summary: try container.decodeIfPresent(CData.self, forKey: .itunesSummary),
      explicit: try container.decodeIfPresent(String.self, forKey: .itunesExplicit),
      duration: try container.decodeIfPresent(iTunesDuration.self, forKey: .itunesDuration),
      image: try container.decodeIfPresent(iTunesImage.self, forKey: .itunesImage)
    )
  }

  private static func decodePodcastProperties(
    from container: KeyedDecodingContainer<CodingKeys>
  ) throws -> PodcastProperties {
    PodcastProperties(
      people: try container.decodeIfPresent([PodcastPerson].self, forKey: .podcastPeople) ?? [],
      transcripts: try container.decodeIfPresent(
        [PodcastTranscript].self, forKey: .podcastTranscripts) ?? [],
      chapters: try container.decodeIfPresent(PodcastChapters.self, forKey: .podcastChapters),
      soundbites: try container.decodeIfPresent([PodcastSoundbite].self, forKey: .podcastSoundbites)
        ?? [],
      season: try container.decodeIfPresent(PodcastSeason.self, forKey: .podcastSeason)
    )
  }

  private static func decodeMediaProperties(
    from container: KeyedDecodingContainer<CodingKeys>
  ) throws -> MediaProperties {
    MediaProperties(
      content: try container.decodeIfPresent(AtomMedia.self, forKey: .mediaContent),
      thumbnail: try container.decodeIfPresent(AtomMedia.self, forKey: .mediaThumbnail)
    )
  }

  private static func decodeWordPressProperties(
    from container: KeyedDecodingContainer<CodingKeys>
  ) throws -> WordPressProperties {
    let (postDateGMT, modifiedDateGMT) = try decodeWordPressDateGMT(from: container)
    let attachmentURL = try decodeWordPressAttachmentURL(from: container)

    return WordPressProperties(
      postID: try container.decodeIfPresent(Int.self, forKey: .wpPostID),
      postDate: try container.decodeIfPresent(Date.self, forKey: .wpPostDate),
      postDateGMT: postDateGMT,
      modifiedDate: try container.decodeIfPresent(Date.self, forKey: .wpModifiedDate),
      modifiedDateGMT: modifiedDateGMT,
      postName: try container.decodeIfPresent(CData.self, forKey: .wpPostName),
      postType: try container.decodeIfPresent(CData.self, forKey: .wpPostType),
      postMeta: try container.decodeIfPresent(
        [WordPressElements.PostMeta].self, forKey: .wpPostMeta) ?? [],
      commentStatus: try container.decodeIfPresent(CData.self, forKey: .wpCommentStatus),
      pingStatus: try container.decodeIfPresent(CData.self, forKey: .wpPingStatus),
      status: try container.decodeIfPresent(CData.self, forKey: .wpStatus),
      postParent: try container.decodeIfPresent(Int.self, forKey: .wpPostParent),
      menuOrder: try container.decodeIfPresent(Int.self, forKey: .wpMenuOrder),
      isSticky: try container.decodeIfPresent(Int.self, forKey: .wpIsSticky),
      postPassword: try container.decodeIfPresent(CData.self, forKey: .wpPostPassword),
      attachmentURL: attachmentURL
    )
  }

  private static func decodeWordPressDateGMT(
    from container: KeyedDecodingContainer<CodingKeys>
  ) throws -> (Date?, Date?) {
    let wpPostDateGMT = try container.decodeIfPresent(String.self, forKey: .wpPostDateGMT)
    let postDateGMT: Date?
    if let wpPostDateGMT = wpPostDateGMT {
      if wpPostDateGMT == "0000-00-00 00:00:00" {
        postDateGMT = nil
      } else {
        postDateGMT = try container.decode(Date.self, forKey: .wpPostDateGMT)
      }
    } else {
      postDateGMT = nil
    }

    let wpModifiedDateGMT = try container.decodeIfPresent(String.self, forKey: .wpModifiedDateGMT)
    let modifiedDateGMT: Date?
    if let wpModifiedDateGMT = wpModifiedDateGMT {
      if wpModifiedDateGMT == "0000-00-00 00:00:00" {
        modifiedDateGMT = nil
      } else {
        modifiedDateGMT = try container.decode(Date.self, forKey: .wpModifiedDateGMT)
      }
    } else {
      modifiedDateGMT = nil
    }

    return (postDateGMT, modifiedDateGMT)
  }

  private static func decodeWordPressAttachmentURL(
    from container: KeyedDecodingContainer<CodingKeys>
  ) throws -> URL? {
    let wpAttachmentURLCDData = try container.decodeIfPresent(CData.self, forKey: .wpAttachmentURL)
    return wpAttachmentURLCDData.map { $0.value }.flatMap(URL.init(string:))
  }
}

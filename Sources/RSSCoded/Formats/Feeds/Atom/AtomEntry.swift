import Foundation

public struct AtomEntry: Codable {
  public let id: RSSGUID
  public let title: String
  public let published: Date?
  public let content: String?
  public let updated: Date
  public let atomCategories: [AtomCategory]
  public let link: Link
  public let author: RSSAuthor?
  public let youtubeChannelID: String?
  public let youtubeVideoID: String?
  public let mediaDescription: String?
  public let creator: String?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case published
    case content
    case updated
    case link
    case author
    case atomCategories = "category"
    case youtubeVideoID = "yt:videoId"
    case youtubeChannelID = "yt:channelId"
    case mediaDescription = "media:description"
    case creator = "dc:creator"
  }
}

extension AtomEntry: Entryable {
  public var categories: [Category] {
    return atomCategories
  }

  public var url: URL {
    return link.href
  }

  public var contentHtml: String? {
    return content?.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  public var summary: String? {
    return nil
  }

  public var media: MediaContent? {
    YouTubeID(entry: self).map(Video.youtube).map(MediaContent.video)
  }
}

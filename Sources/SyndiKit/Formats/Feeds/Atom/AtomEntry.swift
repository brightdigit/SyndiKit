import Foundation

public struct AtomEntry: Codable {
  public let id: EntryID
  public let title: String
  public let published: Date?
  public let content: String?
  public let updated: Date
  public let atomCategories: [AtomCategory]
  public let link: Link
  /// The author of the entry.
  public let author: Author?
  public let youtubeChannelID: String?
  public let youtubeVideoID: String?
  public let mediaDescription: String?
  public let creator: String?
  public let mediaContent: AtomMedia?
  public let mediaThumbnail: AtomMedia?

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
    case mediaContent = "media:content"
    case mediaThumbnail = "media:thumbnail"
  }
}

extension AtomEntry: Entryable {
  public var categories: [EntryCategory] {
    atomCategories
  }

  public var url: URL {
    link.href
  }

  public var contentHtml: String? {
    content?.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  public var summary: String? {
    nil
  }

  public var media: MediaContent? {
    YouTubeIDProperties(entry: self).map(Video.youtube).map(MediaContent.video)
  }

  public var imageURL: URL? {
    mediaThumbnail?.url
  }
}

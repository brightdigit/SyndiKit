import Foundation

public struct AtomEntry: Codable {
  public static let defaultURL = URL(string: "/")!

  /// A permanent, universally unique identifier for an entry.
  public let id: EntryID

  /// a Text construct that conveys a human-readable title
  public let title: String

  /// The most recent instant in time when the entry was published
  public let published: Date?

  /// Content of the trny.
  public let content: String?

  /// The most recent instant in time when the entry was modified in a way
  /// the publisher considers significant.
  public let updated: Date

  /// Cateogires of the entry.
  public let atomCategories: [AtomCategory]

  /// a reference to a Web resource.
  public let links: [Link]
  /// The author of the entry.
  public let authors: [Author]

  /// YouTube channel ID, if from a YouTube channel.
  public let youtubeChannelID: String?

  /// YouTube video ID, if from a YouTube channel.
  public let youtubeVideoID: String?

  /// Short description describing the media object typically a sentence in length.
  /// It has one optional attribute.
  public let mediaDescriptions: [String]

  ///  the person or entity who wrote an item
  public let creators: [String]

  /// Syndicate media content of the entry.
  public let mediaContents: [AtomMedia]

  /// Representative image for the media object.
  public let mediaThumbnails: [AtomMedia]

  /// Grouping of <media:content> elements that are effectively the same content,
  /// yet different representations.
  public let mediaGroup: AtomMediaGroup?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case published
    case content
    case updated
    case links = "link"
    case authors = "author"
    case atomCategories = "category"
    case youtubeVideoID = "yt:videoId"
    case youtubeChannelID = "yt:channelId"
    case mediaDescriptions = "media:description"
    case creators = "dc:creator"
    case mediaContents = "media:content"
    case mediaThumbnails = "media:thumbnail"
    case mediaGroup = "media:group"
  }
}

extension AtomEntry: Entryable {
  public var categories: [EntryCategory] {
    atomCategories
  }

  public var url: URL {
    links.first?.href ?? Self.defaultURL
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
    mediaThumbnails.first?.url
  }
}

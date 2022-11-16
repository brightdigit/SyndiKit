import Foundation

/// An XML-based Web content and metadata syndication format.
///
/// Based on the
/// [specifications here](https://datatracker.ietf.org/doc/html/rfc4287#section-4.1.2).
public struct AtomFeed {
  /// Identifies the feed using a universally unique and permanent URI.
  /// If you have a long-term, renewable lease on your Internet domain name,
  /// then you can feel free to use your website's address.
  public let id: String

  /// Contains a human readable title for the feed.
  /// Often the same as the title of the associated website.
  public let title: String

  /// Contains a human-readable description or subtitle for the feed
  public let description: String?

  /// Contains a human-readable description or subtitle for the feed
  public let subtitle: String?

  /// The publication date for the content in the channel.
  public let published: Date?

  /// The publication date for the content in the channel.
  public let pubDate: Date?

  /// a reference from an entry or feed to a Web resource.
  public let links: [Link]

  /// An individual entry,
  /// acting as a container for metadata and data associated with the entry
  public let entries: [AtomEntry]
  /// The author of the feed.
  public let authors: [Author]

  /// YouTube channel ID, if from a YouTube channel.
  public let youtubeChannelID: String?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case description
    case subtitle
    case published
    case pubDate
    case links = "link"
    case entries = "entry"
    case authors = "author"
    case youtubeChannelID = "yt:channelId"
  }
}

extension AtomFeed: DecodableFeed {
  public var summary: String? {
    description ?? subtitle
  }

  public var children: [Entryable] {
    entries
  }

  public var siteURL: URL? {
    links.first { $0.rel != "self" }?.href
  }

  public var updated: Date? {
    pubDate ?? published
  }

  public var copyright: String? {
    nil
  }

  public var image: URL? {
    nil
  }

  public var syndication: SyndicationUpdate? {
    nil
  }

  static let source: DecoderSetup = DecoderSource.xml
  static var label: String = "Atom"
}

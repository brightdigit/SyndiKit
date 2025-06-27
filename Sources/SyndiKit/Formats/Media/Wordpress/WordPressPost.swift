import Foundation

/// A namespace for WordPress related elements.
public enum WordPressElements: Sendable {}

/// An error type representing a missing field in a WordPress post.
public enum WordPressError: Error, Equatable, Sendable {
  case missingField(WordPressPost.Field)
}

/// A struct representing a WordPress post.
public struct WordPressPost: Sendable {
  /// The type of the post.
  public typealias PostType = String

  /// The comment status of the post.
  public typealias CommentStatus = String

  /// The ping status of the post.
  public typealias PingStatus = String

  /// The status of the post.
  public typealias Status = String

  /// An enum representing the fields of a WordPress post.
  public enum Field: Equatable, Sendable {
    case name
    case title
    case type
    case link
    case pubDate
    case creator
    case body
    case tags
    case categories
    case meta
    case status
    case commentStatus
    case pingStatus
    case parentID
    case menuOrder
    case id
    case isSticky
    case postDate
    case postDateGMT
    case modifiedDate
    case modifiedDateGMT
  }

  /// The name of the post.
  public let name: String

  /// The title of the post.
  public let title: String

  /// The type of the post.
  public let type: PostType

  /// The link of the post.
  public let link: URL

  /// The publication date of the post.
  public let pubDate: Date?

  /// The creator of the post.
  public let creator: String

  /// The body of the post.
  public let body: String

  /// The tags of the post.
  public let tags: [String]

  /// The categories of the post.
  public let categories: [String]

  /// The meta data of the post.
  public let meta: [String: String]

  /// The status of the post.
  public let status: Status

  /// The comment status of the post.
  public let commentStatus: CommentStatus

  /// The ping status of the post.
  public let pingStatus: PingStatus

  /// The parent ID of the post.
  public let parentID: Int?

  /// The menu order of the post.
  public let menuOrder: Int?

  /// The ID of the post.
  public let id: Int

  /// A boolean indicating if the post is sticky.
  public let isSticky: Bool

  /// The post date of the post.
  public let postDate: Date

  /// The post date in GMT of the post.
  public let postDateGMT: Date?

  /// The modified date of the post.
  public let modifiedDate: Date

  /// The modified date in GMT of the post.
  public let modifiedDateGMT: Date?

  /// The attachment URL of the post.
  public let attachmentURL: URL?
}

extension WordPressPost: Hashable {
  public static func == (lhs: WordPressPost, rhs: WordPressPost) -> Bool {
    lhs.id == rhs.id
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension Entryable {
  /// Returns a WordPress post if the entry is an RSS item.
  public var wpPost: WordPressPost? {
    guard let rssItem = self as? RSSItem else {
      return nil
    }

    return try? WordPressPost(item: rssItem)
  }
}

import Foundation

public enum WordPressElements {}

public enum WordPressError: Error, Equatable {
  case missingField(WordPressPost.Field)
}

public struct WordPressPost {
  public typealias PostType = String
  public typealias CommentStatus = String
  public typealias PingStatus = String
  public typealias Status = String

  public enum Field: Equatable {
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

  public let name: String
  public let title: String
  public let type: PostType
  public let link: URL
  public let pubDate: Date?
  public let creator: String
  public let body: String
  public let tags: [String]
  public let categories: [String]
  public let meta: [String: String]
  public let status: Status
  public let commentStatus: CommentStatus
  public let pingStatus: PingStatus
  public let parentID: Int?
  public let menuOrder: Int?
  public let id: Int
  public let isSticky: Bool
  public let postDate: Date
  public let postDateGMT: Date?
  public let modifiedDate: Date
  public let modifiedDateGMT: Date?
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
  public var wpPost: WordPressPost? {
    guard let rssItem = self as? RSSItem else {
      return nil
    }

    return try? WordPressPost(item: rssItem)
  }
}

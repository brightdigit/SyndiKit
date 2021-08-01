import Foundation

public enum WordPressElements {}

public struct WordPressPost {
  public typealias PostType = String
  public typealias CommentStatus = String
  public typealias PingStatus = String
  public typealias Status = String
  init(name: String, title: String, type: PostType, link: URL, pubDate: Date?, creator: String, body: String, tags: [String], categories: [String], meta: [String: String], status: Status, commentStatus: CommentStatus, pingStatus: PingStatus, parentID: Int?, menuOrder: Int?, ID: Int, isSticky: Bool, postDate: Date, postDateGMT: Date?, modifiedDate: Date, modifiedDateGMT: Date?) {
    self.name = name
    self.title = title
    self.type = type
    self.link = link
    self.pubDate = pubDate
    self.creator = creator
    self.body = body
    self.tags = tags
    self.categories = categories
    self.meta = meta
    self.status = status
    self.commentStatus = commentStatus
    self.pingStatus = pingStatus
    self.parentID = parentID
    self.menuOrder = menuOrder
    self.ID = ID
    self.isSticky = isSticky
    self.postDate = postDate
    self.postDateGMT = postDateGMT
    self.modifiedDate = modifiedDate
    self.modifiedDateGMT = modifiedDateGMT
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
  public let ID: Int
  public let isSticky: Bool
  public let postDate: Date
  public let postDateGMT: Date?
  public let modifiedDate: Date
  public let modifiedDateGMT: Date?

  enum Field {
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
    case ID
    case isSticky
    case postDate
    case postDateGMT
    case modifiedDate
    case modifiedDateGMT
  }
}

enum WordPressError: Error {
  case missingField(WordPressPost.Field)
}

public extension WordPressPost {
  init(item: RSSItem) throws {
    let title = item.title
    let link = item.link
    guard let name = item.wpPostName else {
      throw WordPressError.missingField(.name)
    }
    guard let type = item.wpPostType else {
      throw WordPressError.missingField(.type)
    }
    let pubDate = item.pubDate
    guard let creator = item.creators.first else {
      throw WordPressError.missingField(.creator)
    }
    guard let body = item.contentEncoded else {
      throw WordPressError.missingField(.body)
    }
    let categoryTerms = item.categoryTerms
    let meta = item.wpPostMeta ?? []
    guard let status = item.wpStatus else {
      throw WordPressError.missingField(.status)
    }
    guard let commentStatus = item.wpCommentStatus else {
      throw WordPressError.missingField(.commentStatus)
    }
    guard let pingStatus = item.wpPingStatus else {
      throw WordPressError.missingField(.pingStatus)
    }
    guard let parentID = item.wpPostParent else {
      throw WordPressError.missingField(.parentID)
    }
    guard let menuOrder = item.wpMenuOrder else {
      throw WordPressError.missingField(.menuOrder)
    }
    guard let ID = item.wpPostID else {
      throw WordPressError.missingField(.ID)
    }
    guard let isSticky = item.wpIsSticky else {
      throw WordPressError.missingField(.isSticky)
    }
    guard let postDate = item.wpPostDate else {
      throw WordPressError.missingField(.postDate)
    }
    guard let modifiedDate = item.wpModifiedDate else {
      throw WordPressError.missingField(.modifiedDate)
    }
    modifiedDateGMT = item.wpModifiedDateGMT
    self.name = name.value
    self.title = title
    self.type = type.value
    self.link = link
    self.pubDate = pubDate
    self.creator = creator
    self.body = body.value
    let categoryDictionary = Dictionary(grouping: categoryTerms, by: {
      $0.domain
    })
    tags = categoryDictionary["post_tag", default: []].map { $0.value }
    categories = categoryDictionary["category", default: []].map { $0.value }
    self.meta = Dictionary(grouping: meta, by: {
      $0.key.value
    }).compactMapValues {
      $0.last?.value.value
    }
    self.status = status.value
    self.commentStatus = commentStatus.value
    self.pingStatus = pingStatus.value
    self.parentID = parentID
    self.menuOrder = menuOrder
    self.ID = ID
    self.isSticky = (isSticky != 0)
    self.postDate = postDate
    postDateGMT = item.wpPostDateGMT
    self.modifiedDate = modifiedDate
  }
}

public extension Entryable {
  var wpPost: WordPressPost? {
    guard let rssItem = self as? RSSItem else {
      return nil
    }

    return try? WordPressPost(item: rssItem)
  }
}

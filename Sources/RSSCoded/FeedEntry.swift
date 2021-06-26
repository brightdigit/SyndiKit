import Foundation
struct FeedEntry: Codable {
  let id: String
  let title: String
  let published: Date
  let content: String?
  let updated: Date
  let link: FeedLink
  let author: RSSAuthor
  let ytVideoID: String?
  let mediaDescription: String?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case published
    case content
    case updated
    case link
    case author
    case ytVideoID = "yt:videoId"
    case mediaDescription = "media:description"
  }
}

extension FeedEntry: RSSFeedItem {
  var guid: RSSGUID {
    return RSSGUID(from: id)
  }

  var url: URL {
    return link.href
  }

  var contentHtml: String? {
    return content?.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  var summary: String? {
    return nil
  }

  var datePublished: Date? {
    return published
  }

  var rssAuthor: RSSAuthor? {
    return author
  }
}

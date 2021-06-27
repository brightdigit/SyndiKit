import Foundation
struct FeedEntry: Codable {
  let id: RSSGUID
  let title: String
  let published: Date?
  let content: String?
  let updated: Date
  let link: Link
  let author: RSSAuthor?
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

extension FeedEntry: Entryable {

  

  var url: URL {
    return link.href
  }

  var contentHtml: String? {
    return content?.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  var summary: String? {
    return nil
  }

  
  var categories: [String] {
    return []
  }
}

import Foundation

struct AtomEntry: Codable {
  let id: RSSGUID
  let title: String
  let published: Date?
  let content: String?
  let updated: Date
  let atomCategories: [AtomCategory]
  let link: Link
  let author: RSSAuthor?
  let youtubeVideoID: String?
  let mediaDescription: String?

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
    case mediaDescription = "media:description"
  }
}

extension AtomEntry: Entryable {
  var categories: [Category] {
    return atomCategories
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
}

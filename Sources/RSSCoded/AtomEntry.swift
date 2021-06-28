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
  let youtubeChannelID: String?
  let youtubeVideoID: String?
  let mediaDescription: String?
  let creator: String?

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

  var media: MediaContent? {
    YouTubeID(entry: self).map(Video.youtube).map(MediaContent.video)
  }
}

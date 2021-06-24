import Foundation
struct FeedEntry: Codable {
  let id: String
  let title: String
  let published: Date
  let updated: Date
  let link: FeedLink
  let author: RSSAuthor
  let ytVideoID: String?
  let mediaDescription: String?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case published
    case updated
    case link
    case author
    case ytVideoID = "yt:videoId"
    case mediaDescription = "media:description"
  }
}

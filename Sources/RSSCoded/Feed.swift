import Foundation
struct Feed: Codable {
  let id: String
  let title: String
  let published: Date?
  let pubDate: Date?
  let link: FeedLink
  let entry: [FeedEntry]
  let author: RSSAuthor
  let ytChannelID: String?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case published
    case pubDate
    case link
    case entry
    case author
    case ytChannelID = "yt:channelId"
  }
}

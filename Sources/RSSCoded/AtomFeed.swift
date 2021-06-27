import Foundation
struct AtomFeed: Codable {
  let id: String
  let title: String
  let description: String?
  let subtitle: String?
  let published: Date?
  let pubDate: Date?
  let link: [Link]
  let entry: [AtomEntry]
  let author: RSSAuthor
  let ytChannelID: String?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case description
    case subtitle
    case published
    case pubDate
    case link
    case entry
    case author
    case ytChannelID = "yt:channelId"
  }
}


extension AtomFeed : Feedable {
  var url: URL? {
    self.link.first{ $0.rel != "self" }?.href
  }
  
  var updated: Date? {
    return self.pubDate ?? self.published
  }
  
  var copyright: String? {
    return nil
  }
  
  var image: URL? {
    return nil
  }
  
  
}

import Foundation

public struct Site: Codable {
  public let title: String
  public let author: String
  public let siteURL: URL
  public let feedURL: URL
  public let twitterURL: URL?

  public init(
    title: String,
    author: String,
    siteURL: URL,
    feedURL: URL,
    twitterURL: URL?
  ) {
    self.title = title
    self.author = author
    self.siteURL = siteURL
    self.feedURL = feedURL
    self.twitterURL = twitterURL
  }

  enum CodingKeys: String, CodingKey {
    case title
    case author
    case siteURL = "site_url"
    case feedURL = "feed_url"
    case twitterURL = "twitter_url"
  }
}

import Foundation

public struct Site: Codable {
  // swiftlint:disable identifier_name
  public let title: String
  public let author: String
  public let site_url: URL
  public let feed_url: URL
  public let twitter_url: URL?

  public init(
    title: String,
    author: String,
    site_url: URL,
    feed_url: URL,
    twitter_url: URL?
  ) {
    self.title = title
    self.author = author
    self.site_url = site_url
    self.feed_url = feed_url
    self.twitter_url = twitter_url
  }

  // swiftlint:enable identifier_name
}

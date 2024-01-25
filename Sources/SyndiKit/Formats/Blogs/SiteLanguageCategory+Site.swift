import Foundation

// swiftlint:disable nesting
extension SiteLanguageCategory {
  public struct Site: Codable {
    public let title: String
    public let author: String
    public let siteURL: URL
    public let feedURL: URL
    public let twitterURL: URL?

    internal enum CodingKeys: String, CodingKey {
      case title
      case author
      case siteURL = "site_url"
      case feedURL = "feed_url"
      case twitterURL = "twitter_url"
    }
  }
}

public typealias SiteStub = SiteLanguageCategory.Site

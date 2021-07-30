import Foundation
public extension SiteLanguageCategory {
  struct Site: Codable {
    public let title: String
    public let author: String
    public let siteURL: URL
    public let feedURL: URL
    public let twitterURL: URL?

    enum CodingKeys: String, CodingKey {
      case title
      case author
      case siteURL = "site_url"
      case feedURL = "feed_url"
      case twitterURL = "twitter_url"
    }
  }
}

public typealias SiteStub = SiteLanguageCategory.Site

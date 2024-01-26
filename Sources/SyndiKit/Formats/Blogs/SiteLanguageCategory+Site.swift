import Foundation

// swiftlint:disable nesting
extension SiteLanguageCategory {
  /// A ``struct`` representing a site.
  public struct Site: Codable {
    /// The title of the site.
    public let title: String

    /// The author of the site.
    public let author: String

    /// The URL of the site.
    public let siteURL: URL

    /// The URL of the site's feed.
    public let feedURL: URL

    /// The URL of the site's Twitter page.
    public let twitterURL: URL?

    /// Coding keys to map properties to JSON keys.
    internal enum CodingKeys: String, CodingKey {
      case title
      case author
      case siteURL = "site_url"
      case feedURL = "feed_url"
      case twitterURL = "twitter_url"
    }
  }
}

/// A type alias for `SiteLanguageCategory.Site`.
public typealias SiteStub = SiteLanguageCategory.Site

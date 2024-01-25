import Foundation

/// A struct representing a website.
public struct Site {
  /// The title of the website.
  public let title: String

  /// The author of the website.
  public let author: String

  /// The URL of the website.
  public let siteURL: URL

  /// The URL of the website's feed.
  public let feedURL: URL

  /// The URL of the website's Twitter page, if available.
  public let twitterURL: URL?

  /// The category of the website.
  public let category: SiteCategoryType

  /// The language of the website.
  public let language: SiteLanguageType

  /// Initializes a new `Site` instance.
  ///
  /// - Parameters:
  ///   - site: The `SiteLanguageCategory.Site` instance to use as a base.
  ///   - categoryType: The category type of the website.
  ///   - languageType: The language type of the website.
  internal init(
    site: SiteLanguageCategory.Site,
    categoryType: SiteCategoryType,
    languageType: SiteLanguageType
  ) {
    title = site.title
    author = site.author
    siteURL = site.siteURL
    feedURL = site.feedURL
    twitterURL = site.twitterURL
    category = categoryType
    language = languageType
  }
}

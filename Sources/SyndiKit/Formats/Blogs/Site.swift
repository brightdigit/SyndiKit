import Foundation

public struct Site {
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

  public let title: String
  public let author: String
  public let siteURL: URL
  public let feedURL: URL
  public let twitterURL: URL?
  public let category: SiteCategoryType
  public let language: SiteLanguageType
}

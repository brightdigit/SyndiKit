import Foundation

public struct BlogSite {
  internal init(site: Site, categoryType: CategoryType, languageType: LanguageType) {
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
  public let category: CategoryType
  public let language: LanguageType
}

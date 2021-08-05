public struct CategoryLanguage {
  internal init(languageCategory: SiteLanguageCategory, language: SiteLanguageType) {
    type = languageCategory.slug
    descriptor = CategoryDescriptor(
      title: languageCategory.title,
      description: languageCategory.description
    )
    self.language = language
  }

  public let type: SiteCategoryType
  public let descriptor: CategoryDescriptor
  public let language: SiteLanguageType
}

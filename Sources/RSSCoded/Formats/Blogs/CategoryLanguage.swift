public struct CategoryLanguage {
  internal init(languageCategory: LanguageCategory, language: LanguageType) {
    type = languageCategory.slug
    descriptor = CategoryDescriptor(
      title: languageCategory.title,
      description: languageCategory.description
    )
    self.language = language
  }

  public let type: CategoryType
  public let descriptor: CategoryDescriptor
  public let language: LanguageType
}

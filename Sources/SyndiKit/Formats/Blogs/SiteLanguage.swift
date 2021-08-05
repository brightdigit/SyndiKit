public struct SiteLanguage {
  init(content: SiteLanguageContent) {
    type = content.language
    title = content.title
  }

  public let type: SiteLanguageType
  public let title: String
}

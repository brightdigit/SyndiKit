public struct SiteLanguage {
  public let type: SiteLanguageType
  public let title: String

  internal init(content: SiteLanguageContent) {
    type = content.language
    title = content.title
  }
}

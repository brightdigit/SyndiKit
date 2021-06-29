public struct Language {
  init(content: LanguageContent) {
    type = content.language
    title = content.title
  }

  public let type: LanguageType
  public let title: String
}

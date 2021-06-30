public struct Category {
  internal init(languages: [CategoryLanguage]) {
    type = languages.first!.type
    descriptors = Dictionary(grouping: languages, by: { $0.language }).mapValues { $0.first!.descriptor }
  }

  public let type: CategoryType
  public let descriptors: [LanguageType: CategoryDescriptor]
}

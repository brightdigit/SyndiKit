public struct Category {
  internal init?(languages: [CategoryLanguage]) {
    guard let type = languages.first?.type else {
      return nil
    }
    self.type = type
    descriptors = Dictionary(grouping: languages, by: { $0.language })
      .compactMapValues { $0.first?.descriptor }
  }

  public let type: CategoryType
  public let descriptors: [LanguageType: CategoryDescriptor]
}

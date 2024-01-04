public struct SiteCategory {
  public let type: SiteCategoryType
  public let descriptors: [SiteLanguageType: CategoryDescriptor]

  internal init?(languages: [CategoryLanguage]) {
    guard let type = languages.first?.type else {
      return nil
    }
    self.type = type
    descriptors = Dictionary(grouping: languages, by: { $0.language })
      .compactMapValues { $0.first?.descriptor }
  }
}

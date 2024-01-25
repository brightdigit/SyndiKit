/// A struct representing an Atom category.
/// A struct representing a category in a specific language.
///
/// - Parameters:
///   - languageCategory: The category in a specific language.
///   - language: The language of the category.
///
/// - Note: This struct is used internally.
///
/// - SeeAlso: ``SiteCategoryType``
/// - SeeAlso: ``CategoryDescriptor``
/// - SeeAlso: ``SiteLanguageType``
/// - SeeAlso: ``EntryCategory``
public struct CategoryLanguage {
  /// The type of the category.
  public let type: SiteCategoryType

  /// The descriptor of the category.
  public let descriptor: CategoryDescriptor

  /// The language of the category.
  public let language: SiteLanguageType

  /// A struct representing an Atom category.
  ///   Initializes a ``CategoryLanguage`` instance.
  ///
  ///   - Parameters:
  ///     - languageCategory: The category in a specific language.
  ///     - language: The language of the category.
  /// - SeeAlso: ``EntryCategory``
  internal init(languageCategory: SiteLanguageCategory, language: SiteLanguageType) {
    type = languageCategory.slug
    descriptor = CategoryDescriptor(
      title: languageCategory.title,
      description: languageCategory.description
    )
    self.language = language
  }
}

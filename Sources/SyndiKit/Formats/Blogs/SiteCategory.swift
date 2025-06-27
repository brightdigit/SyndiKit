/// A struct representing an Atom category.
/// A struct representing a site category.
///
/// - Note: This struct is used to categorize sites based on their type and descriptors.
///
/// - Parameters:
///   - type: The type of the site category.
///   - descriptors: A dictionary mapping site language types to category descriptors.
///
/// - Important: This struct should not be used directly.
/// Instead, use the ``SiteCategoryBuilder`` to create instances of ``SiteCategory``.
///
/// - SeeAlso: ``SiteCategoryType``
/// - SeeAlso: ``CategoryDescriptor``
/// - SeeAlso: ``CategoryLanguage``
/// - SeeAlso: ``SiteCategoryBuilder``
/// - SeeAlso: ``EntryCategory``
public struct SiteCategory: Sendable {
  /// The type of the site category.
  public let type: SiteCategoryType

  /// A dictionary mapping site language types to category descriptors.
  public let descriptors: [SiteLanguageType: CategoryDescriptor]

  /// A struct representing an Atom category.
  ///   Initializes a ``SiteCategory`` instance with the given languages.
  ///
  ///   - Parameter languages: An array of ``CategoryLanguage`` instances.
  ///
  ///   - Returns: A new ``SiteCategory`` instance
  ///   if at least one language is provided, ``nil`` otherwise.
  /// - SeeAlso: ``EntryCategory``
  internal init?(languages: [CategoryLanguage]) {
    guard let type = languages.first?.type else {
      return nil
    }
    self.type = type
    descriptors = Dictionary(grouping: languages) { $0.language }
      .compactMapValues { $0.first?.descriptor }
  }
}

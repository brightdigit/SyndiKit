/// A struct representing an Atom category.
/// A struct representing a site language.
///
/// Use this struct to define the type and title of a site language.
///
/// - Note: This struct is used internally and should not be directly instantiated.
///
/// - Parameters:
///   - content: The content of the site language.
///
/// - SeeAlso: ``SiteLanguageType``
///
/// - Author: Your Name
/// - SeeAlso: ``EntryCategory``
public struct SiteLanguage {
  /// The type of the site language.
  public let type: SiteLanguageType

  /// The title of the site language.
  public let title: String

  /// A struct representing an Atom category.
  ///   Initializes a new ``SiteLanguage`` instance.
  ///
  ///   - Parameters:
  ///     - content: The content of the site language.
  ///
  ///   - Returns: A new ``SiteLanguage`` instance.
  /// - SeeAlso: ``EntryCategory``
  internal init(content: SiteLanguageContent) {
    type = content.language
    title = content.title
  }
}

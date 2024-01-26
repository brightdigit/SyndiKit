/// A struct representing an Atom category.
/// A struct representing the content of a site in a specific language.
///
/// - Note: This struct conforms to the ``Codable`` protocol.
///
/// - Important: All properties of this struct are read-only.
///
/// - SeeAlso: ``SiteLanguageCategory``
///
/// - Author: Your Name
///
/// - Version: 1.0
/// - SeeAlso: ``EntryCategory``
public struct SiteLanguageContent: Codable {
  /// The language of the site content.
  public let language: String

  /// The title of the site.
  public let title: String

  /// The categories of the site.
  public let categories: [SiteLanguageCategory]
}

/// A struct representing an Atom category.
/// A struct representing a category of site languages.
///
/// - Note: This struct conforms to the ``Codable`` protocol.
///
/// - Important: All properties of this struct are read-only.
///
/// - SeeAlso: ``Site``
/// - SeeAlso: ``EntryCategory``
public struct SiteLanguageCategory: Codable, Sendable {
  /// The title of the category.
  public let title: String

  /// The slug of the category.
  public let slug: String

  /// A description of the category.
  public let description: String

  /// An array of sites belonging to this category.
  public let sites: [Site]
}

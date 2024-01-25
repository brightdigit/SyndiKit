/// A struct representing an Atom category.
/// A descriptor for a category.
///
/// - Note: This struct is publicly accessible.
///
/// - Important: The ``title`` and ``description`` properties are read-only.
///
/// - SeeAlso: ``Category``
/// - SeeAlso: ``EntryCategory``
public struct CategoryDescriptor {
  /// The title of the category.
  public let title: String

  /// The description of the category.
  public let description: String
}

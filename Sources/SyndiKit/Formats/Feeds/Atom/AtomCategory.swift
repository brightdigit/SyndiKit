/// A struct representing an Atom category.
/// A struct representing an Atom category.
///
/// - Note: This struct conforms to the ``Codable`` and ``EntryCategory`` protocols.
///
/// - SeeAlso: ``EntryCategory``
/// - SeeAlso: ``EntryCategory``
public struct AtomCategory: Codable, EntryCategory, Sendable {
  /// The term of the category.
  public let term: String
}

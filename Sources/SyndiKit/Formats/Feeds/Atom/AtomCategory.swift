/**
 A struct representing an Atom category.

 - Note: This struct conforms to the `Codable` and `EntryCategory` protocols.

 - SeeAlso: `EntryCategory`
 */
public struct AtomCategory: Codable, EntryCategory {
  /// The term of the category.
  public let term: String
}

/// Abstract category type.
public protocol EntryCategory: Sendable {
  /// Term used for the category
  var term: String { get }
}

import Foundation

/// Basic Feed type with abstract properties.
public protocol Entryable {
  /// Unique Identifier of the Item.
  var id: EntryID { get }
  /// The URL of the item.
  var url: URL? { get }
  /// The title of the item.
  var title: String { get }
  /// HTML content of the item.
  var contentHtml: String? { get }
  /// The item synopsis.
  var summary: String? { get }
  /// Indicates when the item was published.
  var published: Date? { get }
  /// The author of the item.
  var authors: [Author] { get }
  /// Includes the item in one or more categories.
  var categories: [EntryCategory] { get }
  /// Creator of the item.
  var creators: [String] { get }
  /// Abstraction of Podcast episode or Youtube video info.
  var media: MediaContent? { get }
  /// Image URL of the Item.
  var imageURL: URL? { get }
}

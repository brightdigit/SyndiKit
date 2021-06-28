import Foundation

protocol Category {
  var term: String { get }
}

protocol Entryable {
  var id: RSSGUID { get }
  var url: URL { get }
  var title: String { get }
  var contentHtml: String? { get }
  var summary: String? { get }
  var published: Date? { get }
  var author: RSSAuthor? { get }
  var categories: [Category] { get }
}

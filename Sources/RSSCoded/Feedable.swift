import Foundation

protocol Feedable {
  var title: String { get }
  var url: URL? { get }
  var description: String? { get }
  var updated: Date? { get }
  var copyright: String? { get }
  var image: URL? { get }
}

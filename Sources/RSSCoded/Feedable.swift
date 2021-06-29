import Foundation

protocol Feedable {
  var title: String { get }
  var siteURL: URL? { get }
  var summary: String? { get }
  var updated: Date? { get }
  var copyright: String? { get }
  var image: URL? { get }
  var feedItems: [Entryable] { get }
  var youtubeChannelID: String? { get }
  var author: RSSAuthor? { get }
  var syndication: SyndicationUpdate? { get }
}

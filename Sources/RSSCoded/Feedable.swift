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

//  public let title: String
//  public let summary: String?
//  public let author: String
//  public let siteUrl: URL
//  public let feedUrl: URL
//  public let twitterHandle: String?
//  public let image: URL?
//  public let updated: Date
//  public let ytId: String?
//  public let language: String
//  public let category: String
//  public let items: [FeedItem]
//  public let itemCount: Int?
}

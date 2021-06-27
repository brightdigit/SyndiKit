import Foundation

protocol Feedable {
  var title: String { get }
  var url: URL? { get }
  var description: String? { get }
  var updated: Date? { get }
  var copyright: String? { get }
  var image: URL? { get }
//  let syUpdatePeriod: String?
//  let syUpdateFrequency: String?
//  let item: [RSSItem]
//  let itunesAuthor: String?
//  let itunesImage: String?
//  let itunesOwner: iTunesOwner?
//  let copyright: String?
//  let image: RSSImage?
  //
  //
  //  generator  generator
  //  image  logo
  //
  //  lastBuildDate (in channel)  updated*
}

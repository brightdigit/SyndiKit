import Foundation
struct RSSFeed: Codable {
  let channel: RSSChannel
}

extension RSSFeed : Feedable {
  var title: String {
    return channel.title
  }
  
  var url: URL? {
    return channel.link
  }
  
  var description: String? {
    return channel.description
  }
  
  var updated: Date? {
    return channel.lastBuildDate
  }
  
  var copyright: String? {
    return channel.copyright
  }
  
  var image: URL? {
    return channel.image?.link
  }
  
  
}

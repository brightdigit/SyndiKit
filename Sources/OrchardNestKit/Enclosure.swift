import FeedKit
import Foundation

public struct Enclosure {
  let url: URL
  let type: String

  init?(element: RSSFeedItemEnclosure) {
    guard let url = element.attributes?.url.flatMap(URL.init(string:)) else {
      return nil
    }

    guard let type = element.attributes?.type else {
      return nil
    }

    self.url = url
    self.type = type
  }

  init?(element: AtomFeedEntryLink) {
    guard let url = element.attributes?.href.flatMap(URL.init(string:)) else {
      return nil
    }

    guard let type = element.attributes?.type else {
      return nil
    }

    self.url = url
    self.type = type
  }

  var imageURL: URL? {
    guard type.starts(with: "image/") else {
      return nil
    }

    return url
  }

  var audioURL: URL? {
    guard type.starts(with: "audio/") else {
      return nil
    }

    return url
  }
}

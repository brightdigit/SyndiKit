import Foundation

struct RSSJSONItem: Codable, Equatable {
  internal init(guid: RSSGUID, url: URL, title: String, contentHtml: String?, summary: String?, datePublished: Date?, author: RSSAuthor?) {
    self.guid = guid
    self.url = url
    self.title = title
    self.contentHtml = contentHtml
    self.summary = summary
    self.datePublished = datePublished
    self.author = author
  }

  let guid: RSSGUID
  let url: URL
  let title: String
  let contentHtml: String?
  let summary: String?
  let datePublished: Date?
  let author: RSSAuthor?
}

extension RSSJSONItem {
  init(from item: RSSFeedItem) {
    self.init(guid: item.guid, url: item.url, title: item.title.trimmingCharacters(in: .whitespacesAndNewlines), contentHtml: item.contentHtml, summary: item.summary, datePublished: item.datePublished, author: item.rssAuthor)
  }
}

import Foundation

// struct AnyEntry: Codable, Equatable {
//  internal init(guid: RSSGUID, url: URL, title: String, contentHtml: String?, summary: String?, datePublished: Date?, author: RSSAuthor?) {
//    self.guid = guid
//    self.url = url
//    self.title = title
//    self.contentHtml = contentHtml
//    self.summary = summary
//    self.datePublished = datePublished
//    self.author = author
//  }
//
//  let guid: RSSGUID
//  let url: URL
//  let title: String
//  let contentHtml: String?
//  let summary: String?
//  let datePublished: Date?
//  let author: RSSAuthor?
// }
//
// extension AnyEntry {
//  init(from item: Entryable) {
//    self.init(guid: item.id, url: item.url, title: item.title.trimmingCharacters(in: .whitespacesAndNewlines), contentHtml: item.contentHtml, summary: item.summary, datePublished: item.published, author: item.author)
//  }
// }
// import Foundation
// struct AnyEntry: Codable {
//  let id: RSSGUID
//  let title: String
//  let published: Date?
//  let content: String?
//  let updated: Date
//  let link: Link
//  let author: RSSAuthor?
//  let ytVideoID: String?
//  let mediaDescription: String?
//
//  enum CodingKeys: String, CodingKey {
//    case id
//    case title
//    case published
//    case content
//    case updated
//    case link
//    case author
//    case ytVideoID = "yt:videoId"
//    case mediaDescription = "media:description"
//  }
// }
//
// extension AnyEntry: Entryable {
//  var url: URL {
//    return link.href
//  }
//
//  var contentHtml: String? {
//    return content?.trimmingCharacters(in: .whitespacesAndNewlines)
//  }
//
//  var summary: String? {
//    return nil
//  }
//
//  var categories: [String] {
//    return []
//  }
// }

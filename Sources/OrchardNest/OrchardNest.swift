import Foundation
import FeedKit

let opmlUrls = [
    "https://iosdevdirectory.com/opml/en/updates.opml",
"https://iosdevdirectory.com/opml/en/development.opml",
"https://iosdevdirectory.com/opml/en/design.opml",
"https://iosdevdirectory.com/opml/en/podcasts.opml",
"https://iosdevdirectory.com/opml/en/marketing.opml",
"https://iosdevdirectory.com/opml/en/podcasts.opml",
    "https://iosdevdirectory.com/opml/en/newsletters.opml",
"https://iosdevdirectory.com/opml/en/youtube.opml"
].compactMap(URL.init(string:))

public enum MediaType {
  
}

public struct Item: Codable  {
  public let siteUrl : URL
  public let title : String
  public let summary : String
  public let content: String?
  public let url: URL
  public let image: URL?
  public let ytId: String?
  public let itId: String?
  public let published: Date
}

public struct Channel : Codable {
  public let title : String
  public let summary: String?
  public let author : String
  public let siteUrl : URL
  public let feedUrl : URL
  public let twitterHandle : String?
  //public let image : URL?
  public let updated : Date
  public let language : String
  public let category : String
  public let items : [Item]
  public let itemCount : Int?
  
  public init (language: String, category: String, site: Site) throws {
    let parser = FeedParser(URL: site.feed_url)
    let feed = try parser.parse().get()
    switch feed {
    case .json(let json):
      self.title = json.title ?? site.title
      self.summary = json.description
      self.author =  site.author
      
      self.siteUrl = json.homePageURL.flatMap(URL.init(string:)) ?? site.site_url
      self.feedUrl = json.feedUrl.flatMap(URL.init(string:)) ?? site.feed_url
      self.twitterHandle = site.twitter_url?.lastPathComponent
      //self.image = atom.image
    
      self.updated  = Date()
      self.language = language
      self.category = category
      self.itemCount = json.items?.count
      
      self.items = json.items?.compactMap({ (item) -> Item? in
        let siteUrl : URL = site.site_url
        
        guard let title = item.title, let summary = item.summary, let url = item.externalUrl.flatMap(URL.init(string:)) ?? item.url.flatMap(URL.init(string:)) else {
          return nil
        }
//let ytId: String
        //let itId = item.media.
        let content = item.contentHtml ?? item.contentText
        let published = item.datePublished ?? item.dateModified ?? Date()
        return Item(siteUrl: siteUrl, title: title, summary: summary, content: content, url: url, image: nil, ytId: nil, itId: nil, published: published)
      }) ?? [Item]()
      
    case .rss(let rss) :
      self.title = rss.title ?? site.title
      self.summary = rss.description
      self.author = site.author
      self.siteUrl = rss.link.flatMap(URL.init(string:)) ?? site.site_url
      self.feedUrl = site.feed_url
      self.twitterHandle = site.twitter_url?.lastPathComponent
      //self.image = atom.image
      self.updated = rss.pubDate ?? Date()
      self.language = language
      self.category = category
      
      self.itemCount = rss.items?.count
      self.items = rss.items?.compactMap({ (item) -> Item? in
        let siteUrl : URL = site.site_url
        
        
        guard let title = item.title, let summary = item.description, let url = item.link.flatMap(URL.init(string:)) else {
          return nil
        }
        let content = item.content?.contentEncoded,
//let ytId: String
        //let itId = item.media.
        let published = item.pubDate ?? Date()
        return Item(siteUrl: siteUrl, title: title, summary: summary, content: content, url: url, image: nil, ytId: nil, itId: nil, published: published)
      }) ?? [Item]()
    case .atom(let atom):
      self.title = atom.title ?? site.title
      self.summary = atom.subtitle?.value
      self.author = site.author
      self.siteUrl = site.site_url
      self.feedUrl = site.feed_url
      self.twitterHandle = site.twitter_url?.lastPathComponent
      //self.image = atom.image
      self.updated = atom.updated ?? Date()
      self.language = language
      self.category = category
      self.itemCount = atom.entries?.count
      self.items = atom.entries?.compactMap({ (entry) -> Item?  in
        let siteUrl : URL = site.site_url
        guard let title = entry.title else {
          return nil
        }
        guard let summary  = entry.summary?.value else {
          return nil
        }
        guard let url: URL = entry.links?.first?.attributes?.href.flatMap(URL.init(string:)) else {
          return nil
        }
        return Item(siteUrl: siteUrl, title: title, summary: summary, content: entry.content?.value , url: url, image: nil, ytId: nil, itId: nil, published: entry.published ?? Date())
      }) ?? [Item]()
    }
  }
}

public struct Site : Codable {
  public let title : String
  public let author : String
  public let site_url : URL
  public let feed_url : URL
  public let twitter_url : URL?
}

public struct LanguageCategory : Codable {
  public let title : String
  public let slug : String
  public let description : String
  public let sites : [Site]
}

public struct LanguageContent : Codable {
  public let language : String
  public let title : String
  public let categories : [LanguageCategory]
}

public class BlogReader {
  public init () {
    
  }
  
  public func sites(fromURL url: URL) throws -> [LanguageContent] {
    let decoder = JSONDecoder()
    let data = try Data(contentsOf: url)
    return try decoder.decode([LanguageContent].self, from: data)
  }
  
}



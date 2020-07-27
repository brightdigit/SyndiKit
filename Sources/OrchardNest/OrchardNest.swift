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

public struct Enclosure {
  let url: URL
  let type: String
  
  init?(element : RSSFeedItemEnclosure) {
    guard let url = element.attributes?.url.flatMap(URL.init(string:)) else {
      return nil
    }
    
    guard let type = element.attributes?.type else {
      return nil
    }
    
    self.url = url
    self.type = type
  }
  
  
  
  init?(element : AtomFeedEntryLink) {
    guard let url = element.attributes?.href.flatMap(URL.init(string:)) else {
      return nil
    }
    
    guard let type = element.attributes?.type else {
      return nil
    }
    
    self.url = url
    self.type = type
  }
  
  var imageURL : URL? {
    guard type.starts(with: "image/") else {
      return nil
    }
    
    return self.url
  }
  
  
  var audioURL : URL? {
    guard type.starts(with: "audio/") else {
      return nil
    }
    
    return self.url
  }
}

public struct Item: Codable  {
  public let siteUrl : URL
  public let id : String
  public let title : String
  public let summary : String
  public let content: String?
  public let url: URL
  public let image: URL?
  public let ytId: String?
  public let audio: URL?
  public let published: Date
}

public struct Channel : Codable {
  public let title : String
  public let summary: String?
  public let author : String
  public let siteUrl : URL
  public let feedUrl : URL
  public let twitterHandle : String?
  public let image : URL?
  public let updated : Date
  public let ytId: String?
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
      self.image = json.icon.flatMap(URL.init(string:)) ?? json.favicon.flatMap(URL.init(string:))
    
      self.ytId = nil
      self.updated  = Date()
      self.language = language
      self.category = category
      self.itemCount = json.items?.count
      
      self.items = json.items?.compactMap({ (item) -> Item? in
        let siteUrl : URL = site.site_url
        
        guard let title = item.title, let summary = item.summary, let url = item.externalUrl.flatMap(URL.init(string:)) ?? item.url.flatMap(URL.init(string:)), let id = item.id ?? item.url ?? item.externalUrl else {
          return nil
        }
//let ytId: String
        //let itId = item.media.
        let content = item.contentHtml ?? item.contentText
        let image = item.image.flatMap(URL.init(string:)) ?? item.bannerImage.flatMap(URL.init(string:))
        let published = item.datePublished ?? item.dateModified ?? Date()
        return Item(siteUrl: siteUrl, id: id, title: title, summary: summary, content: content, url: url, image: image, ytId: nil, audio: nil, published: published)
      }) ?? [Item]()
      
    case .rss(let rss) :
      self.title = rss.title ?? site.title
      self.summary = rss.description
      self.author = site.author
      self.siteUrl = rss.link.flatMap(URL.init(string:)) ?? site.site_url
      self.feedUrl = site.feed_url
      self.twitterHandle = site.twitter_url?.lastPathComponent
      self.image = rss.image?.url.flatMap(URL.init(string:))
      //self.image = atom.image
      self.updated = rss.pubDate ?? Date()
      self.language = language
      self.category = category
      self.ytId = nil
      
      self.itemCount = rss.items?.count
      self.items = rss.items?.compactMap({ (item) -> Item? in
        let siteUrl : URL = site.site_url
        
        guard let title = item.title, let summary = item.description ?? item.content?.contentEncoded ?? item.media?.mediaDescription?.value, let id = item.guid?.value ?? item.link, let url = item.link.flatMap(URL.init(string:)) else {
          return nil
        }
        let enclosure = item.enclosure.flatMap(Enclosure.init)
        let content = item.content?.contentEncoded
        let image = item.iTunes?.iTunesImage?.attributes?.href.flatMap(URL.init(string:)) ?? enclosure?.imageURL ?? item.media?.mediaThumbnails?.compactMap{ $0.attributes?.url.flatMap(URL.init(string:)) }.first
//let ytId: String
        //let itId = item.media.
        let published = item.pubDate ?? Date()
        return Item(siteUrl: siteUrl, id: id, title: title, summary: summary, content: content, url: url, image: image, ytId: nil, audio: enclosure?.audioURL, published: published)
      }) ?? [Item]()
    case .atom(let atom):
      
      self.title = atom.title ?? site.title
      self.summary = atom.subtitle?.value
      self.author = site.author
      self.siteUrl = site.site_url
      self.feedUrl = site.feed_url
      self.twitterHandle = site.twitter_url?.lastPathComponent
      self.image = atom.logo.flatMap(URL.init(string:)) ?? atom.logo.flatMap({
        URL(string: $0, relativeTo: site.feed_url)
      }) ?? atom.icon.flatMap(URL.init(string:)) ?? atom.icon.flatMap({
        URL(string: $0, relativeTo: site.feed_url)
      })
      self.updated = atom.updated ?? Date()
      self.language = language
      self.category = category
      self.itemCount = atom.entries?.count
      let ytId : String?
      if atom.id?.starts(with: "yt:channel:") == true {
        ytId = atom.id?.components(separatedBy: ":").last
      } else {
        ytId = nil
      }
      self.ytId = ytId
      self.items = atom.entries?.compactMap({ (entry) -> Item?  in
        let siteUrl : URL = site.site_url
        let media = entry.links?.compactMap(Enclosure.init(element:))
        guard let title = entry.title else {
          return nil
        }
        guard let summary  = entry.summary?.value ?? entry.content?.value ?? entry.media?.mediaGroup?.mediaDescription?.value else {
          return nil
        }
        guard let url: URL = entry.links?.first?.attributes?.href.flatMap(URL.init(string:)) else {
          return nil
        }
        guard let id = entry.id else {
          return nil
        }
        let ytId : String?
        if id.starts(with: "yt:video:") {
          ytId = id.components(separatedBy: ":").last
        } else {
          ytId = nil
        }
        return Item(siteUrl: siteUrl, id: id, title: title, summary: summary, content: entry.content?.value , url: url, image: media?.compactMap{$0.imageURL}.first, ytId: ytId, audio: media?.compactMap{$0.audioURL}.first, published: entry.published ?? Date())
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
  
  public init (
  title : String,
author : String,
site_url : URL,
feed_url : URL,
twitter_url : URL?
  ) {
    self.title = title
    self.author = author
    self.site_url = site_url
    self.feed_url = feed_url
    self.twitter_url = twitter_url
  }
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



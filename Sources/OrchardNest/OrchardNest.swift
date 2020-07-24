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


public struct Site : Codable {
  let title : String
  let author : String
  let site_url : URL
  let feed_url : URL
  let twitter_url : URL?
}

public struct LanguageCategory : Codable {
  let title : String
  let slug : String
  let description : String
  let sites : [Site]
}

public struct LanguageContent : Codable {
  let language : String
  let title : String
  let categories : [LanguageCategory]
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

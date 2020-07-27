import Foundation
import OrchardNest

typealias OrganizedSite = (String, String, Site)
//
//
//let ytURL = URL(string: "https://www.youtube.com/feeds/videos.xml?channel_id=UCDg-YmnNehm3KB0BpytkUJg")!
//
//
//let site = Site(title: "AppleProgramming", author: "Lucas Derraugh", site_url: URL(string: "https://www.youtube.com/channel/UCDg-YmnNehm3KB0BpytkUJg")!, feed_url: ytURL, twitter_url: URL(string: "https://twitter.com/LucasDerraugh")!)
//
//let channel = try? Channel(language: "en", category: "youtube", site: site)
//print(channel?.items.first?.summary)
//exit(0)
let blogs = URL(string: "https://raw.githubusercontent.com/daveverwer/iOSDevDirectory/master/blogs.json")!

let reader = BlogReader()
let sites = try reader.sites(fromURL: blogs)

let orgSites = sites.flatMap { (content) -> [OrganizedSite] in
  let language = content.language
  return content.categories.flatMap { (category) -> [OrganizedSite] in
    category.sites.map{
      (language, category.slug, $0)
    }
  }
}

let channelResults = orgSites.map { (args) in
  return Result {
    try Channel(language: args.0, category: args.1, site: args.2)
  }
}

var errors = [Error]()
var channels = [Channel]()

for result in channelResults {
  switch result {
  case .failure(let error):
    errors.append(error)
  case .success(let channel):
    channels.append(channel)
  }
}

debugPrint(errors)

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let data = try encoder.encode(channels)

try data.write(to:
                URL(fileURLWithPath: "/Users/leo/data.json")
)


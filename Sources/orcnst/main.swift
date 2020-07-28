import Foundation
import OrchardNestKit

typealias OrganizedSite = (String, String, Site)

if true {
  let blogs = URL(string: "https://raw.githubusercontent.com/daveverwer/iOSDevDirectory/master/blogs.json")!

  let reader = BlogReader()
  let sites = try reader.sites(fromURL: blogs)

  let orgSites = sites.flatMap { (content) -> [OrganizedSite] in
    let language = content.language
    return content.categories.flatMap { (category) -> [OrganizedSite] in
      category.sites.map {
        (language, category.slug, $0)
      }
    }
  }

  let channelResults = orgSites.map { args in
    Result {
      try Channel(language: args.0, category: args.1, site: args.2)
    }
  }

  var errors = [Error]()
  var channels = [Channel]()

  for result in channelResults {
    switch result {
    case let .failure(error):
      errors.append(error)
    case let .success(channel):
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

} else {
  let data = try Data(contentsOf: URL(fileURLWithPath: "/Users/leo/Downloads/data.json"))
}

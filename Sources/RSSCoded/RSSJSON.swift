import Foundation
struct RSSJSON: Codable {
  let version: URL
  let title: String
  let homePageUrl: URL
  let description: String?
  let author: RSSAuthor?
  let items: [RSSJSONItem]
}

extension RSSJSON {
  var homePageURLHttp: URL? {
    var components = URLComponents(url: homePageUrl, resolvingAgainstBaseURL: false)
    components?.scheme = "http"
    return components?.url
  }
}

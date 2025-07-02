import SyndiKit

#if swift(<6.1)
  import Foundation
#else
  internal import Foundation
#endif

extension JSONFeed {
  internal var homePageURLHttp: URL? {
    var components = URLComponents(url: homePageUrl, resolvingAgainstBaseURL: false)
    components?.scheme = "http"
    return components?.url
  }
}

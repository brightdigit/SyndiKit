#if swift(<6.0)
  import Foundation
  import SyndiKit
#else
  internal import Foundation
  internal import SyndiKit
#endif

extension JSONFeed {
  internal var homePageURLHttp: URL? {
    var components = URLComponents(url: homePageUrl, resolvingAgainstBaseURL: false)
    components?.scheme = "http"
    return components?.url
  }
}

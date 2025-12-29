#if swift(<6.0)
  import SyndiKit
  import Foundation
#else
  internal import SyndiKit
  internal import Foundation
#endif

extension JSONFeed {
  internal var homePageURLHttp: URL? {
    var components = URLComponents(url: homePageUrl, resolvingAgainstBaseURL: false)
    components?.scheme = "http"
    return components?.url
  }
}

#if swift(<6.1)
  import Foundation
#else
  internal import Foundation
#endif

import SyndiKit

extension JSONFeed {
  internal var homePageURLHttp: URL? {
    var components = URLComponents(url: homePageUrl, resolvingAgainstBaseURL: false)
    components?.scheme = "http"
    return components?.url
  }
}

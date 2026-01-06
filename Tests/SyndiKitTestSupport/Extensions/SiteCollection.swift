#if swift(<6.0)
  import SyndiKit
  import Foundation
#else
  internal import SyndiKit
  internal import Foundation
#endif

extension SiteCollection {
  internal init(contentsOf url: URL, using decoder: JSONDecoder = .init()) throws {
    let data = try Data(contentsOf: url)
    self = try decoder.decode(SiteCollection.self, from: data)
  }
}

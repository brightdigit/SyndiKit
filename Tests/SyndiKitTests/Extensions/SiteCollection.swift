@testable import SyndiKit

#if swift(<6.1)
  import Foundation
#else
  internal import Foundation
#endif

extension SiteCollection {
  internal init(contentsOf url: URL, using decoder: JSONDecoder = .init()) throws {
    let data = try Data(contentsOf: url)
    self = try decoder.decode(SiteCollection.self, from: data)
  }
}

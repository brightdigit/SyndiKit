#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

extension URL {
  var remainingPath: String {
    let path = self.path

    return path == "/" ? "" : path
  }
}

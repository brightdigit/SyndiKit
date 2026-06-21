#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

extension URL {
  internal var remainingPath: String {
    let path = self.path

    return path == "/" ? "" : path
  }
}

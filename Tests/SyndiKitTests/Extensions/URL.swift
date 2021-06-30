import Foundation

extension URL {
  var remainingPath: String {
    let path = self.path

    return path == "/" ? "" : path
  }
}

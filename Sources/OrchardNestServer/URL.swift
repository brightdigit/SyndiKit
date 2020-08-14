import Foundation

extension URL {
  func safeAppendingPathComponent(_ pathComponent: String) -> URL {
    #if os(Linux)
      if pathComponent.isEmpty {
        return self
      } else {
        return appendingPathComponent(pathComponent)
      }
    #else
      return appendingPathComponent(pathComponent)
    #endif
  }
}

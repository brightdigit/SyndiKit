import Foundation

extension URL {
  func ensureAbsolute(_ baseURL: URL) -> URL {
    guard host == nil else {
      return self
    }
    return URL(string: relativeString, relativeTo: baseURL) ?? self
  }
}

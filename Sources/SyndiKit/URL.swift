import Foundation

extension URL {
  internal init?(strict string: String) {
    guard string.starts(with: "http") else {
      return nil
    }

    self.init(string: string)
  }
}

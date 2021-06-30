import Foundation

extension URL {
  init?(strict string: String, withDetector detector: NSDataDetector) {
    guard let match = detector.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count)) else {
      return nil
    }
    guard match.range.length == string.utf16.count else {
      return nil
    }

    self.init(string: string)
  }
}

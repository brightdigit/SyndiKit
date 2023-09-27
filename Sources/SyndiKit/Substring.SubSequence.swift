import Foundation

extension Substring.SubSequence {
  func asDouble() -> Double? {
    Double(self)
  }

  func asInt() -> Int? {
    return Int(self)
  }

  func asExactInt() -> Int? {
    guard let double = Double(self) else { return nil }

    return Int(exactly: double)
  }
}

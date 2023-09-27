import Foundation

extension Substring.SubSequence {
  func asDouble() -> Double? {
    Double(self)
  }

  func asInt() -> Int? {
    guard let double = Double(self) else { return nil }

    return Int(double)
  }

  func asExactInt() -> Int? {
    guard let double = Double(self) else { return nil }

    return Int(exactly: double)
  }
}

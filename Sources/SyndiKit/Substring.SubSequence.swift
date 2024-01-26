import Foundation

extension Substring.SubSequence {
  internal func asDouble() -> Double? {
    Double(self)
  }

  internal func asInt() -> Int? {
    guard let double = Double(self) else {
      return nil
    }

    return Int(double)
  }

  internal func asExactInt() -> Int? {
    guard let double = Double(self) else {
      return nil
    }

    return Int(exactly: double)
  }
}

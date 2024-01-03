import Foundation

extension Collection {
  internal subscript(safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}

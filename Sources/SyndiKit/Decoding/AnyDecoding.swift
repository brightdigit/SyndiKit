import Foundation

internal protocol AnyDecoding: Sendable {
  static var label: String { get }
  func decodeFeed(data: Data) throws -> Feedable
}

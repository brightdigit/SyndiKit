import Foundation

protocol AnyDecoding {
  func decodeFeed(data: Data) throws -> Feedable
}

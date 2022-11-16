import Foundation

protocol AnyDecoding {
  static var label : String { get }
  func decodeFeed(data: Data) throws -> Feedable
}

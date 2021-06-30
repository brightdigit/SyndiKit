import Foundation
import XMLCoder

protocol TypeDecoder {
  func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: DecodableFeed
}

extension TypeDecoder {
  func decodeFeed(_: DecodableFeed.Type, from _: Data) -> Feedable {
    let value: Feedable! = nil
    return value
  }
}

extension JSONDecoder: TypeDecoder {}

extension XMLDecoder: TypeDecoder {}

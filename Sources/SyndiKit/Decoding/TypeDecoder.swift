import Foundation
import XMLCoder

internal protocol TypeDecoder: Sendable {
  func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: DecodableFeed
}

@available(macOS 13.0, *)
extension JSONDecoder: TypeDecoder {}

extension XMLDecoder: @unchecked @retroactive Sendable {}
extension XMLDecoder: TypeDecoder {}

import Foundation
import XMLCoder

internal protocol TypeDecoder: Sendable {
  func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: DecodableFeed
}

#if swift(>=5.7)
// Swift 5.7+ has Foundation Sendable conformance
extension JSONDecoder: TypeDecoder {}
#else
// Swift 5.6 and earlier - use @unchecked Sendable
extension JSONDecoder: @unchecked Sendable {}
extension JSONDecoder: TypeDecoder {}
#endif

extension XMLDecoder: @unchecked Sendable {}
extension XMLDecoder: TypeDecoder {}

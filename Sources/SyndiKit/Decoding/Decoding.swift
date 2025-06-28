import Foundation

internal struct Decoding<DecodingType: DecodableFeed>: AnyDecoding, Sendable {
  internal static var label: String {
    DecodingType.label
  }

  internal let decoder: TypeDecoder

  internal init(for _: DecodingType.Type, using decoder: TypeDecoder) {
    self.decoder = decoder
  }

  internal func decodeFeed(data: Data) throws -> Feedable {
    try decode(data: data)
  }

  internal func decode(data: Data) throws -> DecodingType {
    try decoder.decode(DecodingType.self, from: data)
  }
}

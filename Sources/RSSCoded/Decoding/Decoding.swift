import Foundation

protocol AnyDecoding {
  func decodeFeed(data: Data) throws -> Feedable
}

struct Decoding<DecoderType: TypeDecoder, DecodingType: Decodable & Feedable>: AnyDecoding {
  func decodeFeed(data: Data) throws -> Feedable {
    try decode(data: data)
  }

  let decoder: DecoderType

  init(for _: DecodingType.Type, using decoder: DecoderType) {
    self.decoder = decoder
  }

  func decode(data: Data) throws -> DecodingType {
    try decoder.decode(DecodingType.self, from: data)
  }
}

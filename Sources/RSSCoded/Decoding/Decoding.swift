import Foundation

public struct Decoding<DecodingType: DecodableFeed>: AnyDecoding {
  func decodeFeed(data: Data) throws -> Feedable {
    try decode(data: data)
  }

  let decoder: TypeDecoder

  init(for _: DecodingType.Type, using decoder: TypeDecoder) {
    self.decoder = decoder
  }

  func decode(data: Data) throws -> DecodingType {
    try decoder.decode(DecodingType.self, from: data)
  }
}

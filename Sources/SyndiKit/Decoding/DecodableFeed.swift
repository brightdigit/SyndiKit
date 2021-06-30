import Foundation

public protocol DecodableFeed: Decodable, Feedable {
  static var source: DecoderSetup { get }
}

extension DecodableFeed {
  static func decoding(using decoder: TypeDecoder) -> Decoding<Self> {
    Decoding(for: Self.self, using: decoder)
  }

  static func anyDecoding(using decoder: TypeDecoder) -> AnyDecoding {
    Self.decoding(using: decoder)
  }
}

import Foundation

internal protocol DecodableFeed: Decodable, Feedable, Sendable {
  static var source: DecoderSetup { get }
  static var label: String { get }
}

extension DecodableFeed {
  internal static func decoding(using decoder: TypeDecoder) -> Decoding<Self> {
    Decoding(for: Self.self, using: decoder)
  }

  internal static func anyDecoding(using decoder: TypeDecoder) -> AnyDecoding {
    Self.decoding(using: decoder)
  }
}

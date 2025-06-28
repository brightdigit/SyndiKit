import Foundation

internal protocol CustomDecoderSetup: Sendable {
  func setup(decoder: TypeDecoder)
}

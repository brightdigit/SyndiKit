import Foundation

internal protocol DecoderSetup: Sendable {
  var source: DecoderSource { get }
}

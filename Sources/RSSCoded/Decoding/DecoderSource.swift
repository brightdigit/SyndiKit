import Foundation

public enum DecoderSource: UInt8, DecoderSetup {
  case json = 0x007B
  case xml = 0x003C

  public var source: DecoderSource {
    self
  }
}

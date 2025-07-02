#if swift(<6.1)
  import Foundation
#else
  internal import Foundation
#endif

@testable import SyndiKit

extension Content {
  internal enum Directories {
    static let data = URL(fileURLWithPath: #filePath)
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("Data")
    static let xml = data.appendingPathComponent("XML")
    static let json = data.appendingPathComponent("JSON")
    static let opml = data.appendingPathComponent("OPML")
    static let wordPress = data.appendingPathComponent("WordPress")
  }
}

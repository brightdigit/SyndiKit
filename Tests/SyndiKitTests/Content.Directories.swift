import Foundation
@testable import SyndiKit

extension Content {
  enum Directories {
    static let data = URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("Data")
    static let XML = data.appendingPathComponent("XML")
    static let JSON = data.appendingPathComponent("JSON")
    static let WordPress = data.appendingPathComponent("WordPress")
  }
}

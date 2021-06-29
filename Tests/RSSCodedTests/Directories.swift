import Foundation

enum Directories {
  static let data = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("Data")
  static let XML = data.appendingPathComponent("XML")
  static let JSON = data.appendingPathComponent("JSON")
}

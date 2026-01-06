#if swift(<6.0)
  import SyndiKit
  import Foundation
#else
  internal import SyndiKit
  internal import Foundation
#endif

extension Content {
  internal enum Directories {
    static let data: URL = {
      // Try source-relative path first (works on macOS, Ubuntu CI)
      let sourcePath = URL(fileURLWithPath: #filePath)
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .appendingPathComponent("Data")

      // Check if the source-relative path exists
      if FileManager.default.fileExists(atPath: sourcePath.path) {
        return sourcePath
      }

      // Fall back to current working directory + Data (works on Android emulator)
      // The Android test runner executes from /data/local/tmp/android-xctest
      // and copy-files copies Data/ to that location
      let workingDirPath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        .appendingPathComponent("Data")

      return workingDirPath
    }()

    static let xml = data.appendingPathComponent("XML")
    static let json = data.appendingPathComponent("JSON")
    static let opml = data.appendingPathComponent("OPML")
    static let wordPress = data.appendingPathComponent("WordPress")
  }
}

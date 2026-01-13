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
      // Strategy 1: Working directory relative (most reliable for SPM/WASM/Android)
      // Try this FIRST because it works on WASM when tests run from package root
      let workingDirPath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        .appendingPathComponent("Data")

      if FileManager.default.fileExists(atPath: workingDirPath.path) {
        return workingDirPath
      }

      // Strategy 2: Source-relative path (works on macOS/Linux)
      let sourcePath = URL(fileURLWithPath: #filePath)
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .appendingPathComponent("Data")

      if FileManager.default.fileExists(atPath: sourcePath.path) {
        return sourcePath
      }

      // Strategy 3: Parent directory search (for nested execution contexts)
      var searchPath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
      for _ in 0..<3 {
        let candidatePath = searchPath.appendingPathComponent("Data")
        if FileManager.default.fileExists(atPath: candidatePath.path) {
          return candidatePath
        }
        searchPath = searchPath.deletingLastPathComponent()
      }

      // Fallback to working directory path (original behavior)
      // If this doesn't exist, the error will be caught by try! in Content.ResultDictionary
      return workingDirPath
    }()

    static let xml = data.appendingPathComponent("XML")
    static let json = data.appendingPathComponent("JSON")
    static let opml = data.appendingPathComponent("OPML")
    static let wordPress = data.appendingPathComponent("WordPress")
  }
}

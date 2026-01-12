#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

extension FileManager {
  internal func dataFromDirectory(at sourceURL: URL) throws -> [(String, Result<Data, Error>)] {
    #if os(WASI)
      // WASM: Use explicit file list instead of contentsOfDirectory
      // Directory enumeration is not supported in WASI (POSIX error 58)
      // but individual file reading works fine
      let directoryName = sourceURL.lastPathComponent
      let filenames: [String]

      switch directoryName {
      case "XML":
        filenames = TestFileManifests.xmlFiles
      case "JSON":
        filenames = TestFileManifests.jsonFiles
      case "OPML":
        filenames = TestFileManifests.opmlFiles
      case "WordPress":
        filenames = TestFileManifests.wordPressFiles
      default:
        throw CocoaError(.fileNoSuchFile)
      }

      return filenames.map { filename in
        let url = sourceURL.appendingPathComponent(filename)
        let result = Result { try Data(contentsOf: url) }
        let key = url.deletingPathExtension().lastPathComponent
        return (key, result)
      }
    #else
      // macOS/Linux: Use contentsOfDirectory as normal
      let urls = try contentsOfDirectory(
        at: sourceURL,
        includingPropertiesForKeys: nil,
        options: []
      )

      return urls.mapPairResult { try Data(contentsOf: $0) }
        .map { ($0.0.deletingPathExtension().lastPathComponent, $0.1) }
    #endif
  }
}

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
      // Only OPML tests run on WASM due to memory constraints (~144KB total)

      // Verify we're accessing the OPML directory (sanity check for future maintainers)
      guard sourceURL.lastPathComponent == "OPML" else {
        throw CocoaError(.fileNoSuchFile)
      }

      // Explicit list of OPML test files
      // Update this list when adding new test fixtures to Data/OPML/
      let filenames: [String] = [
        "category.opml",
        "category_invalidExpansionState.opml",
        "development.opml",
        "directory.opml",
        "placesLived.opml",
        "simpleScript.opml",
        "states.opml",
        "subscriptionList.opml",
      ]

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

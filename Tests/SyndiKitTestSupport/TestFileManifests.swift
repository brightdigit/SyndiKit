#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

#if os(WASI)
/// WASM-specific file manifests for test data directories.
///
/// These lists enable test fixture loading without FileManager.contentsOfDirectory()
/// which is not supported in WASI environments (POSIX error 58).
///
/// While path resolution and file reading work in WASM:
/// - ✅ FileManager.currentDirectoryPath returns `/` (wasmtime maps --dir . to root)
/// - ✅ FileManager.fileExists(atPath:) works correctly
/// - ✅ Data(contentsOf:) can read individual files
/// - ❌ FileManager.contentsOfDirectory() is unsupported
///
/// **WASM Memory Optimization:**
/// Only includes smallest feeds (<50KB) to minimize memory usage in WASM's constrained environment.
/// Large feeds (empowerapps-show: 2.9MB, it-guy: 4.6MB) are excluded to prevent OOM crashes.
///
/// Maintainer note: When adding new test fixture files to Data/, update these lists.
internal enum TestFileManifests {

  /// OPML test files in Data/OPML/
  static let opmlFiles: [String] = [
    "category.opml",
    "category_invalidExpansionState.opml",
    "development.opml",
    "directory.opml",
    "placesLived.opml",
    "simpleScript.opml",
    "states.opml",
    "subscriptionList.opml"
  ]

  /// WordPress export test files in Data/WordPress/
  static let wordPressFiles: [String] = [
    "articles.xml",
    "tutorials.xml"
  ]
}
#endif

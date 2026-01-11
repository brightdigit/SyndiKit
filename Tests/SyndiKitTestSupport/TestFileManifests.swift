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
  /// XML feed test files in Data/XML/ (small/medium subset for WASM)
  /// Only feeds <110KB to stay within memory limits
  /// Excludes largest feeds: empowerapps-show (2.9MB), it-guy (4.6MB), swiftweeklybrief (2.9MB)
  static let xmlFiles: [String] = [
    "senestenyt.xml",          // 7.4K
    "apple.releases.xml",      // 11K
    "avanderlee.xml",          // 15K
    "donnywals.xml",           // 15K
    "kilo.youtube.xml",        // 20K
    "appfigures.youtube.xml",  // 22K
    "vincent.youtube.xml",     // 24K
    "revenuecat.xml",          // 32K
    "cocoacasts.xml",          // 36K
    "stewart.youtube.xml",     // 37K
    "tundsdev.youtube.xml",    // 37K
    "atomicbird.xml",          // 39K
    "timac.xml",               // 45K
    "news.rss",                // 60K - used in tests
    "andyibanez.xml",          // 77K
    "mokacoding.xml",          // 98K
    "ios-goodies.xml",         // 101K
    "swiftpackageindex.xml"    // 102K
  ]

  /// JSON feed test files in Data/JSON/ (small/medium subset for WASM)
  /// Only feeds <110KB to stay within memory limits
  static let jsonFiles: [String] = [
    "senestenyt.json",
    "apple.releases.json",
    "avanderlee.json",
    "donnywals.json",
    "kilo.youtube.json",
    "appfigures.youtube.json",
    "vincent.youtube.json",
    "revenuecat.json",
    "cocoacasts.json",
    "stewart.youtube.json",
    "tundsdev.youtube.json",
    "atomicbird.json",
    "timac.json",
    "andyibanez.json",
    "mokacoding.json",
    "ios-goodies.json",
    "swiftpackageindex.json"
  ]

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

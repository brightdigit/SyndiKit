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
/// Maintainer note: When adding new test fixture files to Data/, update these lists.
internal enum TestFileManifests {
  /// XML feed test files in Data/XML/
  static let xmlFiles: [String] = [
    "advancedswift.xml",
    "andyibanez.xml",
    "appfigures.youtube.xml",
    "apple.developer.xml",
    "apple.releases.xml",
    "atomicbird.xml",
    "avanderlee.xml",
    "cnn_latest.xml",
    "cocoacasts.xml",
    "donnywals.xml",
    "empowerapps-show-cdata_summary.xml",
    "empowerapps-show.xml",
    "enekoalonso.xml",
    "fivestars.xml",
    "ideveloper.xml",
    "ios-goodies.xml",
    "iosdevweekly.xml",
    "it-guy.xml",
    "kilo.youtube.xml",
    "mecid.xml",
    "mjtsai.xml",
    "mokacoding.xml",
    "news.rss",
    "radar.xml",
    "raywenderlich.xml",
    "revenuecat.xml",
    "rhonabwy.xml",
    "senestenyt.xml",
    "stewart.youtube.xml",
    "swiftbysundell.xml",
    "swiftpackageindex.xml",
    "swiftweeklybrief.xml",
    "timac.xml",
    "tundsdev.youtube.xml",
    "vincent.youtube.xml",
    "wait-wait-dont-tell-me.xml",
    "wwdcnotes.xml"
  ]

  /// JSON feed test files in Data/JSON/
  static let jsonFiles: [String] = [
    "advancedswift.json",
    "andyibanez.json",
    "appfigures.youtube.json",
    "apple.developer.json",
    "apple.releases.json",
    "atomicbird.json",
    "avanderlee.json",
    "cnn_latest.json",
    "cocoacasts.json",
    "donnywals.json",
    "empowerapps-show.json",
    "enekoalonso.json",
    "fivestars.json",
    "ideveloper.json",
    "ios-goodies.json",
    "iosdevweekly.json",
    "it-guy.json",
    "kilo.youtube.json",
    "mecid.json",
    "mjtsai.json",
    "mokacoding.json",
    "radar.json",
    "raywenderlich.json",
    "revenuecat.json",
    "rhonabwy.json",
    "senestenyt.json",
    "stewart.youtube.json",
    "swiftbysundell.json",
    "swiftpackageindex.json",
    "swiftweeklybrief.json",
    "timac.json",
    "tundsdev.youtube.json",
    "vincent.youtube.json",
    "wwdcnotes.json"
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

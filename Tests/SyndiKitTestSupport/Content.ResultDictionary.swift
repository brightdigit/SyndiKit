import XMLCoder

#if swift(<6.0)
  import SyndiKit
  import Foundation
#else
  internal import SyndiKit
  internal import Foundation
#endif

enum Content {
  typealias ResultDictionary<SuccessValueType> = [String: Result<SuccessValueType, Error>]

  #if os(WASI)
  /// Lazy-loading dictionary for WASM to avoid memory exhaustion
  /// Loads and decodes files on-demand without caching to minimize memory usage
  ///
  /// Note: Marked @unchecked Sendable because tests run synchronously in WASM
  /// and decoding happens from a single thread
  final class LazyResultDictionary<SuccessValueType>: Collection, @unchecked Sendable {
    typealias Element = (key: String, value: Result<SuccessValueType, Error>)
    typealias Index = Array<String>.Index

    private let directoryURL: URL
    private let decoder: @Sendable (Data) throws -> SuccessValueType
    private let fileNames: [String]

    init(directoryURL: URL, fileNames: [String], decoder: @escaping @Sendable (Data) throws -> SuccessValueType) {
      self.directoryURL = directoryURL
      self.fileNames = fileNames
      self.decoder = decoder
    }

    subscript(key: String) -> Result<SuccessValueType, Error>? {
      // Check if feed is in the allowed list
      // This prevents loading large feeds that could cause OOM on WASM
      let fileName = key + "." + (
        directoryURL.lastPathComponent == "JSON" ? "json" :
        directoryURL.lastPathComponent == "OPML" ? "opml" : "xml"
      )

      guard fileNames.contains(fileName) else {
        return nil  // Feed not available in WASM (too large)
      }

      // Load and decode on-demand without caching
      // This keeps memory usage minimal in WASM's 256MB constraint
      let fileURL = directoryURL.appendingPathComponent(key).appendingPathExtension(
        directoryURL.lastPathComponent == "JSON" ? "json" :
        directoryURL.lastPathComponent == "OPML" ? "opml" : "xml"
      )

      let result = Result<SuccessValueType, Error> {
        let data = try Data(contentsOf: fileURL)
        return try decoder(data)
      }

      return result
    }

    var startIndex: Index { fileNames.startIndex }
    var endIndex: Index { fileNames.endIndex }

    func index(after i: Index) -> Index {
      fileNames.index(after: i)
    }

    subscript(position: Index) -> Element {
      let fileName = fileNames[position]
      let key = URL(fileURLWithPath: fileName).deletingPathExtension().lastPathComponent
      let value = self[key]!
      return (key, value)
    }
  }
  #endif

  fileprivate static func resultDictionaryFrom<SuccessValueType>(
    directoryURL: URL,
    by closure: @escaping (Data) throws -> SuccessValueType
  ) throws -> ResultDictionary<SuccessValueType> {
    let xmlDataSet = Result {
      try FileManager.default.dataFromDirectory(at: directoryURL)
    }

    return try xmlDataSet.map { xmlDataSet in
      xmlDataSet.flatResultMapValue(closure)
    }.map(Dictionary.init(uniqueKeysWithValues:)).get()
  }

  @available(macOS 13.0, *)
  static let synDecoder = SynDecoder()
  static var xmlDecoder: XMLCoder.XMLDecoder {
    XMLCoder.XMLDecoder()
  }

  #if os(WASI)
  // WASM: Use lazy loading to avoid memory exhaustion from loading all 37 XML files at once
  @available(macOS 13.0, *)
  static let xmlFeeds = LazyResultDictionary<Feedable>(
    directoryURL: Directories.xml,
    fileNames: TestFileManifests.xmlFiles,
    decoder: Self.synDecoder.decode(_:)
  )
  @available(macOS 13.0, *)
  static let jsonFeeds = LazyResultDictionary<Feedable>(
    directoryURL: Directories.json,
    fileNames: TestFileManifests.jsonFiles,
    decoder: Self.synDecoder.decode(_:)
  )
  #else
  // macOS/Linux: Load all feeds eagerly (faster, more memory available)
  @available(macOS 13.0, *)
  static let xmlFeeds = try! Content.resultDictionaryFrom(
    directoryURL: Directories.xml,
    by: Self.synDecoder.decode(_:)
  )
  @available(macOS 13.0, *)
  static let jsonFeeds = try! Content.resultDictionaryFrom(
    directoryURL: Directories.json,
    by: Self.synDecoder.decode(_:)
  )
  #endif
  static let opml = try! Content.resultDictionaryFrom(
    directoryURL: Directories.opml,
    by: Self.xmlDecoder.decodeOPML(_:)
  )
  static let wordpressDataSet = try! FileManager.default.dataFromDirectory(
    at: Directories.wordPress
  )
  static let blogs: SiteCollection = try! .init(
    contentsOf: Directories.data.appendingPathComponent("blogs.json"))
}

extension XMLCoder.XMLDecoder {
  func decodeOPML(_ data: Data) throws -> OPML {
    try decode(OPML.self, from: data)
  }
}

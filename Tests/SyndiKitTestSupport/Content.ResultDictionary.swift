import XMLCoder

#if swift(<6.0)
  import Foundation
  import SyndiKit
#else
  internal import Foundation
  internal import SyndiKit
#endif

internal enum Content {
  internal typealias ResultDictionary<SuccessValueType> = [String: Result<SuccessValueType, Error>]

  @available(macOS 13.0, *)
  internal static let synDecoder = SynDecoder()
  internal static var xmlDecoder: XMLCoder.XMLDecoder {
    XMLCoder.XMLDecoder()
  }

  #if !os(WASI)
    // macOS/Linux: Load all feeds eagerly (faster, more memory available)
    // swift-format-ignore: NeverUseForceTry
    @available(macOS 13.0, *)
    // swiftlint:disable:next force_try
    internal static let xmlFeeds = try! Content.resultDictionaryFrom(
      directoryURL: Directories.xml,
      by: Self.synDecoder.decode(_:)
    )
    // swift-format-ignore: NeverUseForceTry
    @available(macOS 13.0, *)
    // swiftlint:disable:next force_try
    internal static let jsonFeeds = try! Content.resultDictionaryFrom(
      directoryURL: Directories.json,
      by: Self.synDecoder.decode(_:)
    )
    // swift-format-ignore: NeverUseForceTry
    // swiftlint:disable:next force_try
    internal static let wordpressDataSet = try! FileManager.default.dataFromDirectory(
      at: Directories.wordPress
    )
  #endif
  // WASM: Only OPML tests run (uses explicit file list in FileManager.dataFromDirectory)
  // All other test data (xmlFeeds, jsonFeeds, wordpressDataSet) is disabled above due to memory constraints
  // swift-format-ignore: NeverUseForceTry
  // swiftlint:disable:next force_try
  internal static let opml = try! Content.resultDictionaryFrom(
    directoryURL: Directories.opml,
    by: Self.xmlDecoder.decodeOPML(_:)
  )
  // swift-format-ignore: NeverUseForceTry
  // swiftlint:disable:next force_try
  internal static let blogs: SiteCollection = try! .init(
    contentsOf: Directories.data.appendingPathComponent("blogs.json")
  )

  fileprivate static func resultDictionaryFrom<SuccessValueType>(
    directoryURL: URL,
    by closure: @escaping (Data) throws -> SuccessValueType
  ) throws -> ResultDictionary<SuccessValueType> {
    let xmlDataSet = Result {
      try FileManager.default.dataFromDirectory(at: directoryURL)
    }

    return
      try xmlDataSet
      .map { xmlDataSet in
        xmlDataSet.flatResultMapValue(closure)
      }
      .map(Dictionary.init(uniqueKeysWithValues:))
      .get()
  }
}

extension XMLCoder.XMLDecoder {
  internal func decodeOPML(_ data: Data) throws -> OPML {
    try decode(OPML.self, from: data)
  }
}

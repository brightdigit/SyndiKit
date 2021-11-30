import Foundation
@testable import SyndiKit

typealias ResultDictionary<SuccessValueType> = [String: Result<SuccessValueType, Error>]

extension SiteCollection {
  init(contentsOf url: URL, using decoder: JSONDecoder = .init()) throws {
    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()

    self = try decoder.decode(SiteCollection.self, from: data)
  }
}

enum Content {
  fileprivate static func resultDictionaryFrom<SuccessValueType>(directoryURL: URL, by closure: @escaping (Data) throws -> SuccessValueType) throws -> ResultDictionary<SuccessValueType> {
    let xmlDataSet = Result { try FileManager.default.dataFromDirectory(at: directoryURL) }

    return try xmlDataSet.map { xmlDataSet in
      xmlDataSet.flatResultMapValue(closure)
    }.map(Dictionary.init(uniqueKeysWithValues:)).get()
  }

  enum Directories {
    static let data = URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("Data")
    static let XML = data.appendingPathComponent("XML")
    static let JSON = data.appendingPathComponent("JSON")
    static let WordPress = data.appendingPathComponent("WordPress")
  }

  static let decoder = SynDecoder()

  static let xmlFeeds = try! Content.resultDictionaryFrom(directoryURL: Directories.XML, by: Self.decoder.decode(_:))
  static let jsonFeeds = try! Content.resultDictionaryFrom(directoryURL: Directories.JSON, by: Self.decoder.decode(_:))
  static let wordpressDataSet = try! FileManager.default.dataFromDirectory(at: Directories.WordPress)
  static let blogs: SiteCollection = try! .init(contentsOf: Directories.data.appendingPathComponent("blogs.json"))
}

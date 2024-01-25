import Foundation

extension FileManager {
  internal func dataFromDirectory(at sourceURL: URL) throws -> [(String, Result<Data, Error>)] {
    let urls = try contentsOfDirectory(
      at: sourceURL,
      includingPropertiesForKeys: nil,
      options: []
    )

    return urls.mapPairResult { try Data(contentsOf: $0) }
      .map { ($0.0.deletingPathExtension().lastPathComponent, $0.1) }
  }
}

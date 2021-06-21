@testable import RSSCoded
import XCTest

extension Sequence {
  func mapResult<Success>(_ transform: @escaping (Element) throws -> Success) -> [Result<Success, Error>] {
    map { element in
      Result { try transform(element) }
    }
  }

  func flatResultMap<Success, NewSuccess>(_ transform: @escaping (Success) throws -> NewSuccess) -> [Result<NewSuccess, Error>] where Element == Result<Success, Error> {
    map {
      $0.flatMap { success in
        Result {
          try transform(success)
        }
      }
    }
  }
}

struct JSONDecoding<DecodingType: Decodable> {
  let decoder: JSONDecoder

  init(for _: DecodingType.Type, using decoder: JSONDecoder = .init()) {
    self.decoder = decoder
  }

  func decode(data: Data) throws -> DecodingType {
    return try decoder.decode(DecodingType.self, from: data)
  }
}

final class RSSCodedTests: XCTestCase {
  func testExample() throws {
    let sourceURL = URL(string: #file)!.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("Data").appendingPathComponent("JSON")

    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .iso8601

    let decoding = JSONDecoding(for: RSSJSON.self, using: decoder)

    let urls = try FileManager.default.contentsOfDirectory(at: sourceURL, includingPropertiesForKeys: nil, options: [])

    let feeds = urls.mapResult {
      try Data(contentsOf: $0)
    }.flatResultMap { try decoding.decode(data: $0) }

    for feed in feeds {
      guard case let .failure(error) = feed else {
        continue
      }
      dump(error)
    }
  }
}

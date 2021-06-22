@testable import RSSCoded
import XCTest
import XMLCoder
extension Sequence {
  func mapPairResult<Success>(_ transform: @escaping (Element) throws -> Success) -> [(Element, Result<Success, Error>)] {
    map { element in
      (element, Result { try transform(element) })
    }
  }

  func mapResult<Success>(_ transform: @escaping (Element) throws -> Success) -> [Result<Success, Error>] {
    map { element in
      Result { try transform(element) }
    }
  }

  func flatResultMapValue<SuccessKey, SuccessValue, NewSuccess>(_ transform: @escaping (SuccessValue) throws -> NewSuccess) -> [(SuccessKey, Result<NewSuccess, Error>)] where Element == (SuccessKey, Result<SuccessValue, Error>) {
    map {
      let value = $0.1.flatMap { value in
        Result { try transform(value) }
      }
      return ($0.0, value)
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

protocol Decoder {
  func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

extension JSONDecoder: Decoder {}

extension XMLDecoder: Decoder {}

struct Decoding<DecoderType: Decoder, DecodingType: Decodable> {
  let decoder: DecoderType

  init(for _: DecodingType.Type, using decoder: DecoderType) {
    self.decoder = decoder
  }

  func decode(data: Data) throws -> DecodingType {
    return try decoder.decode(DecodingType.self, from: data)
  }
}

final class RSSCodedTests: XCTestCase {
  func testExampleRSS() throws {
    let sourceURL = URL(string: #file)!.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("Data").appendingPathComponent("JSON")

    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    decoder.dateDecodingStrategy = .custom { decoder in

      let container = try decoder.singleValueContainer()
      let dateStr = try container.decode(String.self)

      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
      if let date = formatter.date(from: dateStr) {
        return date
      }
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
      if let date = formatter.date(from: dateStr) {
        return date
      }
      throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Invalid Date"))
    }

    let decoding = Decoding(for: RSSJSON.self, using: decoder)

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

  func testExampleXML() throws {
    let sourceURL = URL(string: #file)!.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("Data").appendingPathComponent("XML")

    let decoder = XMLDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    decoder.dateDecodingStrategy = .custom { decoder in

      let container = try decoder.singleValueContainer()
      let dateStr = try container.decode(String.self)

      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
      if let date = formatter.date(from: dateStr) {
        return date
      }
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
      if let date = formatter.date(from: dateStr) {
        return date
      }
      throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Invalid Date"))
    }

    let decoding = Decoding(for: RSS.self, using: decoder)

    let urls = try FileManager.default.contentsOfDirectory(at: sourceURL, includingPropertiesForKeys: nil, options: [])

    let feeds = urls.mapPairResult {
      try Data(contentsOf: $0)
    }.flatResultMapValue { try decoding.decode(data: $0) }

    var report = [String: Error]()
    for feed in feeds {
      guard case let .failure(error) = feed.1 else {
        continue
      }
      report[feed.0.deletingPathExtension().lastPathComponent] = error
    }
    for (key, value) in report {
      print(key, value)
    }
    print(report.count, "errors")
  }
}

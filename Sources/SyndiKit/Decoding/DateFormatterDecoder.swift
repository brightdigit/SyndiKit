import Foundation

internal struct DateFormatterDecoder: Sendable {
  internal enum RSS: Sendable {
    private static let dateFormatStrings = [
      "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX",
      "yyyy-MM-dd'T'HH:mm:ssXXXXX",
      "E, d MMM yyyy HH:mm:ss zzz",
      "yyyy-MM-dd HH:mm:ss"
    ]

    internal static let decoder = DateFormatterDecoder(
      basedOnFormats: Self.dateFormatStrings
    )
  }

  private let formatters: [DateFormatter]

  internal init(basedOnFormats formats: [String]) {
    formatters = formats.map(Self.isoPOSIX(withFormat:))
  }

  private static func isoPOSIX(withFormat dateFormat: String) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = dateFormat
    return formatter
  }

  internal func decodeString(_ dateStr: String) -> Date? {
    for formatter in formatters {
      if let date = formatter.date(from: dateStr) {
        return date
      }
    }
    return nil
  }

  @Sendable
  internal func decode(from decoder: Decoder) throws -> Date {
    let container = try decoder.singleValueContainer()
    let dateStr = try container.decode(String.self)

    if let date = decodeString(dateStr) {
      return date
    }

    let context = DecodingError.Context(
      codingPath: decoder.codingPath,
      debugDescription: "Invalid Date from '\(dateStr)'"
    )
    throw DecodingError.dataCorrupted(context)
  }
}

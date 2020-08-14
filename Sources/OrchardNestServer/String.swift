import Foundation

public extension String {
  func asURL() throws -> URL {
    guard let url = URL(string: self) else {
      throw InvalidURLFormat()
    }
    return url
  }
}

public extension String {
  var plainTextShort: String {
    var result: String

    result = trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    guard result.count > 240 else {
      return result
    }
    return result.prefix(240).components(separatedBy: " ").dropLast().joined(separator: " ").appending("...")
  }
}

#if swift(<6.0)
  import Foundation
#else
  internal import Foundation
#endif

extension String {
  internal func trimAndNilIfEmpty() -> String? {
    let text = trimmingCharacters(in: .whitespacesAndNewlines)
    return text.isEmpty ? nil : text
  }

  internal func normalizeLineEndings() -> String {
    replacingOccurrences(of: "\r\n", with: "\n")
      .replacingOccurrences(of: "\r", with: "\n")
  }
}

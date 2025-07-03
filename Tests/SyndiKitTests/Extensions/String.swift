#if swift(<6.1)
  import Foundation
#else
  internal import Foundation
#endif

extension String {
  internal func trimAndNilIfEmpty() -> String? {
    let text = trimmingCharacters(in: .whitespacesAndNewlines)
    return text.isEmpty ? nil : text
  }
}

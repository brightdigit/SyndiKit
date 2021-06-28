import Foundation

struct EntryCategoryCodable: Codable {
  let type: EntryCategoryType
  let value: String?
  let seconds: Int?
}

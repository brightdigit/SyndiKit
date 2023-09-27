import Foundation

public extension OPML {
  struct Head: Codable, Equatable {
    public let title: String?
    public let dateCreated: String?
    public let dateModified: String?
    public let ownerName: String?
    public let ownerEmail: String?
    public let ownerId: String?
    public let docs: String?
    public let expansionStates: [Int]?
    public let vertScrollState: Int?
    public let windowTop: Int?
    public let windowLeft: Int?
    public let windowBottom: Int?
    public let windowRight: Int?

    enum CodingKeys: String, CodingKey {
      case title
      case dateCreated
      case dateModified
      case ownerName
      case ownerEmail
      case ownerId
      case docs
      case expansionStates = "expansionState"
      case vertScrollState
      case windowTop
      case windowLeft
      case windowBottom
      case windowRight
    }

    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      title = try container.decodeIfPresent(String.self, forKey: .title)
      dateCreated = try container.decodeIfPresent(String.self, forKey: .dateCreated)
      dateModified = try container.decodeIfPresent(String.self, forKey: .dateModified)
      ownerName = try container.decodeIfPresent(String.self, forKey: .ownerName)
      ownerEmail = try container.decodeIfPresent(String.self, forKey: .ownerEmail)
      ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId)
      docs = try container.decodeIfPresent(String.self, forKey: .docs)
      vertScrollState = try container.decodeIfPresent(Int.self, forKey: .vertScrollState)
      windowTop = try container.decodeIfPresent(Int.self, forKey: .windowTop)
      windowLeft = try container.decodeIfPresent(Int.self, forKey: .windowLeft)
      windowBottom = try container.decodeIfPresent(Int.self, forKey: .windowBottom)
      windowRight = try container.decodeIfPresent(Int.self, forKey: .windowRight)

      expansionStates = try container
        .decodeIfPresent(String.self, forKey: .expansionStates)?
        .components(separatedBy: ", ")
        .filter { $0.isEmpty == false }
        .map {
          guard let value = Int($0) else {
            let context = DecodingError.Context(
              codingPath: [CodingKeys.expansionStates],
              debugDescription: "Invalid expansionState type '\($0)'"
            )

            throw DecodingError.typeMismatch(Int.self, context)
          }

          return value
        }
    }
  }
}

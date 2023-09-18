import Foundation

public extension OPML {
  struct Head: Codable, Equatable {
    public let title: String?
    public let dateCreated: String?
    public let dateModified: String?
    public let ownerName: String?
    public let ownerEmail: String?
    public let expansionState: String?
    public let vertScrollState: String?
    public let windowTop: String?
    public let windowLeft: String?
    public let windowBottom: String?
    public let windowRight: String?

    enum CodingKeys: String, CodingKey {
      case title
      case dateCreated
      case dateModified
      case ownerName
      case ownerEmail
      case expansionState
      case vertScrollState
      case windowTop
      case windowLeft
      case windowBottom
      case windowRight
    }
  }
}

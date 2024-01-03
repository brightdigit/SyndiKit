import Foundation

extension OPML {
  public struct Head: Codable, Equatable {
    public let title: String?
    public let dateCreated: String?
    public let dateModified: String?
    public let ownerName: String?
    public let ownerEmail: String?
    public let ownerId: String?
    public let docs: String?
    public let expansionStates: ListString<Int>?
    public let vertScrollState: Int?
    public let windowTop: Int?
    public let windowLeft: Int?
    public let windowBottom: Int?
    public let windowRight: Int?

    // swiftlint:disable:next nesting
    internal enum CodingKeys: String, CodingKey {
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
  }
}

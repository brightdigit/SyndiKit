import Foundation

public struct EntryChannel: Codable {
  public let id: UUID
  public let title: String
  public let author: String
  public let twitterHandle: String?
  public let imageURL: URL?

  public init(
    id: UUID,
    title: String,
    author: String,
    twitterHandle: String?,
    imageURL: URL?
  ) {
    self.id = id
    self.title = title
    self.author = author
    self.twitterHandle = twitterHandle
    self.imageURL = imageURL
  }
}

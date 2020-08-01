import Foundation

public struct EntryItem: Codable {
  public let id: UUID
  public let channel: EntryChannel
  public let feedId: String
  public let title: String
  public let summary: String
  public let url: URL
  public let imageURL: URL?
  public let publishedAt: Date

  public init(id: UUID,
              channel: EntryChannel,
              feedId: String,
              title: String,
              summary: String,
              url: URL,
              imageURL: URL?,
              publishedAt: Date)
  {
    self.id = id
    self.channel = channel
    self.feedId = feedId
    self.title = title
    self.summary = summary
    self.url = url
    self.imageURL = imageURL
    self.publishedAt = publishedAt
  }
}

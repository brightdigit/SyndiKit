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
  public let category: EntryCategory

  public init(id: UUID,
              channel: EntryChannel,
              category: EntryCategory,
              feedId: String,
              title: String,
              summary: String,
              url: URL,
              imageURL: URL?,
              publishedAt: Date) {
    self.id = id
    self.channel = channel
    self.feedId = feedId
    self.title = title
    self.summary = summary
    self.url = url
    self.imageURL = imageURL
    self.category = category
    self.publishedAt = publishedAt
  }
}

public extension EntryItem {
  var seconds: Int? {
    if case let .youtube(_, seconds) = category {
      return seconds
    } else
    if case let .podcasts(_, seconds) = category {
      return seconds
    }
    return nil
  }

  var podcastEpisodeURL: URL? {
    if case let .podcasts(url, _) = category {
      return url
    }
    return nil
  }

  var youtubeID: String? {
    if case let .youtube(id, _) = category {
      return id
    }
    return nil
  }

  var twitterShareLink: String {
    let text = title + (channel.twitterHandle.map { " from @\($0)" } ?? "")
    return "https://twitter.com/intent/tweet?text=\(text)&via=orchardnest&url=\(url)"
  }

  var fallbackImageURL: URL? {
    return imageURL ?? channel.imageURL
  }
}

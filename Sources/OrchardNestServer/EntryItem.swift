import OrchardNestKit

public extension EntryItem {
  init(entry: Entry) throws {
    try self.init(
      id: entry.requireID(),
      channel: EntryChannel(channel: entry.channel),
      category: entry.category(),
      feedId: entry.feedId,
      title: entry.title,
      summary: entry.summary,
      url: entry.url.asURL(),
      imageURL: entry.imageURL?.asURL(),
      publishedAt: entry.publishedAt
    )
  }
}

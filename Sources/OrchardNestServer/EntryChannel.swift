import OrchardNestKit

public extension EntryChannel {
  init(channel: Channel) throws {
    try self.init(
      id: channel.requireID(),
      title: channel.title,
      siteURL: channel.siteUrl.asURL(),
      author: channel.author,
      twitterHandle: channel.twitterHandle,
      imageURL: channel.imageURL?.asURL(),
      podcastAppleId: channel.$podcasts.value?.first?.appleId
    )
  }
}

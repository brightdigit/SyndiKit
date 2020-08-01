import OrchardNestKit

struct ChannelFeedItemsConfiguration {
  let channel: Channel
  let youtubeId: String?
  let items: [FeedItem]

  init(channels: [String: Channel], feedArgs: FeedConfiguration) {
    let channel: Channel
    if let oldChannel = channels[feedArgs.channel.siteUrl.absoluteString] {
      channel = oldChannel
    } else {
      channel = Channel()
    }
    channel.title = feedArgs.channel.title
    channel.$language.id = feedArgs.languageCode
    channel.$category.id = feedArgs.categorySlug
    channel.subtitle = feedArgs.channel.summary
    channel.author = feedArgs.channel.author
    channel.siteUrl = feedArgs.channel.siteUrl.absoluteString
    channel.feedUrl = feedArgs.channel.feedUrl.absoluteString
    channel.twitterHandle = feedArgs.channel.twitterHandle
    channel.imageURL = feedArgs.channel.image?.absoluteString

    channel.publishedAt = feedArgs.channel.updated

    self.channel = channel
    items = feedArgs.channel.items
    youtubeId = feedArgs.channel.ytId
  }
}

extension ChannelFeedItemsConfiguration {
  func feedItems() throws -> [FeedItemConfiguration] {
    let channelId = try channel.requireID()
    return items.map { FeedItemConfiguration(channelId: channelId, feedItem: $0) }
  }

  var youtubeChannel: YouTubeChannel? {
    guard let id = channel.id, let youtubeId = self.youtubeId else {
      return nil
    }
    return YouTubeChannel(channelId: id, youtubeId: youtubeId)
  }
}

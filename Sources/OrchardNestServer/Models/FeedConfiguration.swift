import OrchardNestKit

struct FeedConfiguration {
  let categorySlug: String
  let languageCode: String
  let channel: FeedChannel
}

extension FeedConfiguration {
  static func from(
    categorySlug: String,
    languageCode: String,
    channel: FeedChannel,
    langMap: [String: Language],
    catMap: [String: Category]
  ) -> FeedResult {
    guard let newLangId = langMap[languageCode]?.id else {
      return .failure(.invalidParent(channel.feedUrl, languageCode))
    }
    guard let newCatId = catMap[categorySlug]?.id else {
      return .failure(.invalidParent(channel.feedUrl, categorySlug))
    }
    return .success(FeedConfiguration(categorySlug: newCatId, languageCode: newLangId, channel: channel))
  }
}

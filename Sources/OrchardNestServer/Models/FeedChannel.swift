import OrchardNestKit
import Vapor

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

struct EmptyError: Error {}

extension FeedChannel {
  static func parseSite(_ site: OrganizedSite, using client: Client, on eventLoop: EventLoop) -> EventLoopFuture<Result<FeedChannel, FeedError>> {
    return client.get(URI(string: site.site.feed_url.absoluteString)).map { (response) -> Data? in
      response.body.map { buffer in
        Data(buffer: buffer)
      }
    }.flatMapAlways { (result) -> EventLoopFuture<Result<FeedChannel, FeedError>> in
      let newResult = result.mapError { FeedError.download(site.site.feed_url, $0) }.flatMap { (data) -> Result<Data, FeedError> in
        guard let data = data else {
          return .failure(.empty(site.site.feed_url))
        }
        return .success(data)
      }.flatMap { data in
        Result {
          try FeedChannel(language: site.languageCode, category: site.categorySlug, site: site.site, data: data)
        }.mapError { .parser(site.site.feed_url, $0) }
      }.flatMap { (channel) -> Result<FeedChannel, FeedError> in
        guard channel.items.count > 0 || channel.itemCount == channel.items.count else {
          return .failure(.items(site.site.feed_url))
        }
        return .success(channel)
      }
      return eventLoop.future(newResult)
    }
  }
}

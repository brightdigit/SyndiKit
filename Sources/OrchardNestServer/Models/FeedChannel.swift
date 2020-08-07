import OrchardNestKit
import Vapor

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

struct EmptyError: Error {}

extension FeedChannel {
  static func parseSite(_ site: OrganizedSite, using _: Client, on eventLoop: EventLoop) -> EventLoopFuture<Result<FeedChannel, FeedError>> {
    // let uri = URI(string: site.site.feed_url.absoluteString)
    // let headers = HTTPHeaders([("Host", uri.host!), ("User-Agent", "OrchardNest-Robot"), ("Accept", "*/*")])

    let promise = eventLoop.makePromise(of: Result<Data, Error>.self)
    URLSession.shared.dataTask(with: site.site.feed_url) { data, _, error in
      let result: Result<Data, Error>
      if let error = error {
        result = .failure(error)
      } else if let data = data {
        result = .success(data)
      } else {
        promise.fail(EmptyError())
        return
      }
      promise.succeed(result)
    }.resume()
    return promise.futureResult.flatMap { (result) -> EventLoopFuture<Result<FeedChannel, FeedError>> in

      let responseBody: Data
      do {
        responseBody = try result.get()
      } catch {
        return eventLoop.future(.failure(.download(site.site.feed_url, error)))
      }
      let channel: FeedChannel
      do {
        channel = try FeedChannel(language: site.languageCode, category: site.categorySlug, site: site.site, data: responseBody)
      } catch {
        return eventLoop.future(.failure(.parser(site.site.feed_url, error)))
      }
      guard channel.items.count > 0 || channel.itemCount == channel.items.count else {
        return eventLoop.future(.failure(.items(site.site.feed_url)))
      }
      return eventLoop.future(.success(channel))
    }
  }
}

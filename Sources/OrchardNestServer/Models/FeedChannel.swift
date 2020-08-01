import OrchardNestKit
import Vapor

extension FeedChannel {
  static func parseSite(_ site: OrganizedSite, using client: Client, on eventLoop: EventLoop) -> EventLoopFuture<Result<FeedChannel, FeedError>> {
    let uri = URI(string: site.site.feed_url.absoluteString)
    let headers = HTTPHeaders([("Host", uri.host!), ("User-Agent", "OrchardNest-Robot"), ("Accept", "*/*")])

    let request = ClientRequest(method: .GET, url: uri, headers: headers, body: nil)

    return client.send(request)
      .flatMapAlways { (result) -> EventLoopFuture<Result<FeedChannel, FeedError>> in

        let responseBody: ByteBuffer?
        do {
          responseBody = try result.get().body
        } catch {
          // context.logger.info("\(site.title) URLERROR: \(error.localizedDescription) \(site.feed_url)")
          return eventLoop.future(.failure(.download(site.site.feed_url, error)))
        }
        guard let buffer = responseBody else {
          return eventLoop.future(.failure(.empty(site.site.feed_url)))
        }
        // let feedChannelSet = body.map { (buffer) -> FeedResult in
        let channel: FeedChannel
        do {
          channel = try FeedChannel(language: site.languageCode, category: site.categorySlug, site: site.site, data: Data(buffer: buffer))
        } catch {
          // context.logger.info("\(site.title) FEDERROR: \(error.localizedDescription) \(site.feed_url)")
          return eventLoop.future(.failure(.parser(site.site.feed_url, error)))
        }
        guard channel.items.count > 0 || channel.itemCount == channel.items.count else {
          // context.logger.info("\(site.title) ITMERROR \(site.feed_url)")
          return eventLoop.future(.failure(.items(site.site.feed_url)))
        }
//        guard let newLangId = langMap[lang]?.id else {
//          return context.eventLoop.future(.failure(.invalidParent(site.feed_url, lang)))
//        }
//        guard let newCatId = catMap[cat]?.id else {
//          return context.eventLoop.future(.failure(.invalidParent(site.feed_url, cat)))
//        }
        // context.logger.info("downloaded \(site.title)")
        return eventLoop.future(.success(channel))
        // }
        // return context.eventLoop.future(feedChannelSet)
      }
  }
}

import Foundation

public struct FeedChannel: Codable {
  static let youtubeImgBaseURL = URL(string: "https://img.youtube.com/vi/")!
  public static func imageURL(fromYoutubeId ytId: String) -> URL {
    return youtubeImgBaseURL.appendingPathComponent(ytId).appendingPathComponent("hqdefault.jpg")
  }

  public let title: String
  public let summary: String?
  public let author: String
  public let siteUrl: URL
  public let feedUrl: URL
  public let twitterHandle: String?
  public let image: URL?
  public let updated: Date
  public let ytId: String?
  public let language: String
  public let category: String
  public let items: [FeedItem]
  public let itemCount: Int?
}

#if canImport(FeedKit)
  import FeedKit
  public extension FeedChannel {
    // swiftlint:disable:next function_body_length
    init(language: String, atomCategories: String, site: Site, data: Data) throws {
      let parser = FeedParser(data: data)
      let feed = try parser.parse().get()

      switch feed {
      case let .json(json):
        title = json.title ?? site.title
        summary = json.description
        author = site.author
        siteUrl = json.homePageURL.flatMap(URL.init(string:)) ?? site.site_url
        feedUrl = json.feedUrl.flatMap(URL.init(string:)) ?? site.feed_url
        twitterHandle = site.twitter_url?.lastPathComponent
        image = json.icon.flatMap(URL.init(string:)) ?? json.favicon.flatMap(URL.init(string:))

        ytId = nil
        updated = Date()
        self.language = language
        self.atomCategories = atomCategories
        itemCount = json.items?.count

        items = json.items?.compactMap { item -> FeedItem? in
          let siteUrl: URL = site.site_url

          guard let title = item.title,
                let summary = item.summary,
                let url = item.externalUrl.flatMap(URL.init(string:)) ?? item.url.flatMap(URL.init(string:)),
                let id = item.id ?? item.url ?? item.externalUrl,
                let published = item.datePublished ?? item.dateModified
          else {
            return nil
          }
          let content = item.contentHtml ?? item.contentText
          let image = item.image.flatMap(URL.init(string:)) ?? item.bannerImage.flatMap(URL.init(string:))

          return FeedItem(
            siteUrl: siteUrl,
            id: id,
            title: title,
            summary: summary,
            content: content,
            url: url,
            image: image,
            ytId: nil,
            audio: nil, duration: nil,
            published: published
          )
        } ?? [FeedItem]()

      case let .rss(rss):
        title = rss.title ?? site.title
        summary = rss.description
        author = site.author
        siteUrl = rss.links.flatMap(URL.init(string:)) ?? site.site_url
        feedUrl = site.feed_url
        twitterHandle = site.twitter_url?.lastPathComponent
        image = rss.image?.url.flatMap(URL.init(string:)) ?? rss.iTunes?.iTunesImage?.attributes?.href.flatMap(URL.init(string:))
        // self.image = atom.image
        updated = rss.pubDate ?? Date()
        self.language = language
        self.atomCategories = atomCategories
        ytId = nil

        itemCount = rss.items?.count
        items = rss.items?.compactMap { item -> FeedItem? in
          let siteUrl: URL = site.site_url

          guard let title = item.title,
                let summary = item.description ??
                item.content?.contentEncoded ??
                item.media?.mediaDescription?.value,
                let id = item.guid?.value ?? item.links,
                let itemUrl = item.links.flatMap(URL.init(string:)),
                let published = item.pubDate ?? item.dublinCore?.dcDate
          else {
            return nil
          }
          let url = itemUrl.ensureAbsolute(siteUrl)
          let enclosure = item.enclosure.flatMap(Enclosure.init)
          let content = item.content?.contentEncoded
          let image = item.iTunes?.iTunesImage?.attributes?.href.flatMap(URL.init(string:)) ??
            enclosure?.imageURL ??
            item.media?.mediaThumbnails?.compactMap {
              $0.attributes?.url.flatMap(URL.init(string:))
            }.first
          // let ytId: String
          // let itId = item.media.

          return FeedItem(
            siteUrl: siteUrl,
            id: id,
            title: title,
            summary: summary,
            content: content,
            url: url,
            image: image,
            ytId: nil,
            audio: enclosure?.audioURL,
            duration: item.iTunes?.iTunesDuration,
            published: published
          )
        } ?? [FeedItem]()
      case let .atom(atom):

        title = atom.title ?? site.title
        summary = atom.subtitle?.value
        author = site.author
        siteUrl = site.site_url
        feedUrl = site.feed_url
        twitterHandle = site.twitter_url?.lastPathComponent
        updated = atom.updated ?? Date()
        self.language = language
        self.atomCategories = atomCategories
        itemCount = atom.entries?.count
        let ytId: String?
        if atom.id?.starts(with: "yt:channel:") == true {
          ytId = atom.id?.components(separatedBy: ":").last
        } else {
          ytId = nil
        }
        image = atom.logo.flatMap(URL.init(string:)) ?? atom.logo.flatMap {
          URL(string: $0, relativeTo: site.feed_url)
        } ?? atom.icon.flatMap(URL.init(string:)) ?? atom.icon.flatMap {
          URL(string: $0, relativeTo: site.feed_url)
        } ?? ytId.map(Self.imageURL)
        self.ytId = ytId
        items = atom.entries?.compactMap { entries -> FeedItem? in
          let siteUrl: URL = site.site_url
          let media = entries.links?.compactMap(Enclosure.init(element:))
          guard let title = entries.title else {
            return nil
          }
          guard let summary = entries.summary?.value ??
            entries.content?.value ??
            entries.media?.mediaGroup?.mediaDescription?.value
          else {
            return nil
          }
          guard let entryUrl: URL = entries.links?.first?.attributes?.href.flatMap(URL.init(string:)) else {
            return nil
          }
          guard let id = entries.id else {
            return nil
          }

          guard let published = entries.published else {
            return nil
          }
          let ytId: String?
          if id.starts(with: "yt:video:") {
            ytId = id.components(separatedBy: ":").last
          } else {
            ytId = nil
          }
          let url = entryUrl.ensureAbsolute(siteUrl)
          return FeedItem(
            siteUrl: siteUrl,
            id: id,
            title: title,
            summary: summary,
            content: entries.content?.value,
            url: url,
            image: media?.compactMap { $0.imageURL }.first,
            ytId: ytId,
            audio: media?.compactMap { $0.audioURL }.first, duration: nil,
            published: published
          )
        } ?? [FeedItem]()
      }
    }
  }
#endif

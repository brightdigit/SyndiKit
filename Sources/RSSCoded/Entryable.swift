import Foundation

protocol PodcastEpisodeProtocol {
  var title: String? { get }
  var episode: Int? { get }
  var author: String? { get }
  var subtitle: String? { get }
  var summary: String? { get }
  var explicit: String? { get }
  var duration: iTunesDuration? { get }
  var image: iTunesImage? { get }
  var enclosure: Enclosure { get }
}

protocol YouTubeIDProtocol {
  var videoID: String { get }
  var channelID: String { get }
}

struct PodcastEpisode: PodcastEpisodeProtocol {
  let title: String?
  let episode: Int?
  let author: String?
  let subtitle: String?
  let summary: String?
  let explicit: String?
  let duration: iTunesDuration?
  let image: iTunesImage?
  let enclosure: Enclosure

  init?(rssItem: RSSItem) {
    guard let enclosure = rssItem.enclosure else {
      return nil
    }
    title = rssItem.itunesTitle
    episode = rssItem.itunesEpisode?.value
    author = rssItem.itunesAuthor
    subtitle = rssItem.itunesSubtitle
    summary = rssItem.itunesSummary
    explicit = rssItem.itunesExplicit
    duration = rssItem.itunesDuration
    image = rssItem.itunesImage
    self.enclosure = enclosure
  }
}

struct YouTubeID: YouTubeIDProtocol {
  let videoID: String

  let channelID: String

  init?(entry: AtomEntry) {
    guard let channelID = entry.youtubeChannelID, let videoID = entry.youtubeVideoID else {
      return nil
    }
    self.channelID = channelID
    self.videoID = videoID
  }
}

enum Video {
  case youtube(YouTubeIDProtocol)
}

enum MediaContent {
  case podcast(PodcastEpisodeProtocol)
  case video(Video)
}

protocol Category {
  var term: String { get }
}

protocol Entryable {
  var id: RSSGUID { get }
  var url: URL { get }
  var title: String { get }
  var contentHtml: String? { get }
  var summary: String? { get }
  var published: Date? { get }
  var author: RSSAuthor? { get }
  var categories: [Category] { get }
  var creator: String? { get }
  var media: MediaContent? { get }
}

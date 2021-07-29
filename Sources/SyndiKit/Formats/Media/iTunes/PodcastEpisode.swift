import Foundation
struct PodcastEpisode: PodcastEpisodeProtocol {
  public let title: String?
  public let episode: Int?
  public let author: String?
  public let subtitle: String?
  public let summary: String?
  public let explicit: String?
  public let duration: TimeInterval?
  public let image: iTunesImage?
  public let enclosure: Enclosure

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
    duration = rssItem.itunesDuration?.value
    image = rssItem.itunesImage
    self.enclosure = enclosure
  }
}

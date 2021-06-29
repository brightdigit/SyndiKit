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

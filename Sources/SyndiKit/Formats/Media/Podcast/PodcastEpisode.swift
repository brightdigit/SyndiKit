import Foundation

internal struct PodcastEpisodeProperties: PodcastEpisode {
  internal let title: String?
  internal let episode: Int?
  internal let author: String?
  internal let subtitle: String?
  internal let summary: String?
  internal let explicit: String?
  internal let duration: TimeInterval?
  internal let image: iTunesImage?
  internal let enclosure: Enclosure
  internal let people: [PodcastPerson]

  internal init?(rssItem: RSSItem) {
    guard let enclosure = rssItem.enclosure else {
      return nil
    }
    title = rssItem.itunesTitle
    episode = rssItem.itunesEpisode?.value
    author = rssItem.itunesAuthor
    subtitle = rssItem.itunesSubtitle
    summary = rssItem.itunesSummary?.value
    explicit = rssItem.itunesExplicit
    duration = rssItem.itunesDuration?.value
    image = rssItem.itunesImage
    self.enclosure = enclosure
    people = rssItem.podcastPeople
  }
}

public protocol PodcastEpisode {
  var title: String? { get }
  var episode: Int? { get }
  var author: String? { get }
  var subtitle: String? { get }
  var summary: String? { get }
  var explicit: String? { get }
  var duration: TimeInterval? { get }
  var image: iTunesImage? { get }
  var enclosure: Enclosure { get }
  var people: [PodcastPerson] { get }
}

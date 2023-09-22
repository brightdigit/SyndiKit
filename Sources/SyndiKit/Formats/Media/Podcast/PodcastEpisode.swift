import Foundation
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

struct PodcastEpisodeProperties: PodcastEpisode {
  public let title: String?
  public let episode: Int?
  public let author: String?
  public let subtitle: String?
  public let summary: String?
  public let explicit: String?
  public let duration: TimeInterval?
  public let image: iTunesImage?
  public let enclosure: Enclosure
  public let people: [PodcastPerson]

  init?(rssItem: RSSItem) {
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
    people = rssItem.podcastPeople ?? []
  }
}

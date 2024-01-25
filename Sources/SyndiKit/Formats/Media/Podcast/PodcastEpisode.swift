import Foundation

/// A struct representing properties of a podcast episode.
public struct PodcastEpisodeProperties: PodcastEpisode {
  /// The title of the episode.
  public let title: String?

  /// The episode number.
  public let episode: Int?

  /// The author of the episode.
  public let author: String?

  /// The subtitle of the episode.
  public let subtitle: String?

  /// A summary of the episode.
  public let summary: String?

  /// Indicates if the episode contains explicit content.
  public let explicit: String?

  /// The duration of the episode.
  public let duration: TimeInterval?

  /// The image associated with the episode.
  public let image: iTunesImage?

  /// The enclosure of the episode.
  public let enclosure: Enclosure

  /// The people involved in the episode.
  public let people: [PodcastPerson]

  /**
   Initializes a `PodcastEpisodeProperties` instance from an `RSSItem`.

   - Parameter rssItem: The `RSSItem` to extract the properties from.

   - Returns: An initialized `PodcastEpisodeProperties` instance,
   or `nil` if the `enclosure` property is missing.
   */
  public init?(rssItem: RSSItem) {
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

/// A protocol representing a podcast episode.
public protocol PodcastEpisode {
  /// The title of the episode.
  var title: String? { get }

  /// The episode number.
  var episode: Int? { get }

  /// The author of the episode.
  var author: String? { get }

  /// A summary of the episode.
  var summary: String? { get }

  /// The subtitle of the episode.
  var subtitle: String? { get }

  /// The duration of the episode.
  var duration: TimeInterval? { get }

  /// The image associated with the episode.
  var image: iTunesImage? { get }

  /// Indicates if the episode contains explicit content.
  var explicit: String? { get }

  /// The enclosure of the episode.
  var enclosure: Enclosure { get }

  /// The people involved in the episode.
  var people: [PodcastPerson] { get }
}

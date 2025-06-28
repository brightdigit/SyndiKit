import Foundation

/// A struct representing properties of a podcast episode.
internal struct PodcastEpisodeProperties: PodcastEpisode, Sendable {
  /// The title of the episode.
  internal let title: String?

  /// The episode number.
  internal let episode: Int?

  /// The author of the episode.
  internal let author: String?

  /// The subtitle of the episode.
  internal let subtitle: String?

  /// A summary of the episode.
  internal let summary: String?

  /// Indicates if the episode contains explicit content.
  internal let explicit: String?

  /// The duration of the episode.
  internal let duration: TimeInterval?

  /// The image associated with the episode.
  internal let image: iTunesImage?

  /// The enclosure of the episode.
  internal let enclosure: Enclosure

  /// The people involved in the episode.
  internal let people: [PodcastPerson]

  /// A struct representing an Atom category.
  ///   Initializes a ``PodcastEpisodeProperties`` instance from an ``RSSItem``.
  ///
  ///   - Parameter rssItem: The ``RSSItem`` to extract the properties from.
  ///
  ///   - Returns: An initialized ``PodcastEpisodeProperties`` instance,
  ///   or ``nil`` if the ``enclosure`` property is missing.
  /// - SeeAlso: ``EntryCategory``
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

/// A protocol representing a podcast episode.
public protocol PodcastEpisode: Sendable {
  /// The title of the episode.
  var title: String? { get }

  /// The episode number.
  var episode: Int? { get }

  /// The author of the episode.
  var author: String? { get }

  /// The subtitle of the episode.
  var subtitle: String? { get }

  /// A summary of the episode.
  var summary: String? { get }

  /// Indicates if the episode contains explicit content.
  var explicit: String? { get }

  /// The duration of the episode.
  var duration: TimeInterval? { get }

  /// The image associated with the episode.
  var image: iTunesImage? { get }

  /// The enclosure of the episode.
  var enclosure: Enclosure { get }

  /// The people involved in the episode.
  var people: [PodcastPerson] { get }
}

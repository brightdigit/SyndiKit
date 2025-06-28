import Foundation

/// A struct representing an Atom category.
/// Represents different types of media content.
///
/// - podcast: A podcast episode.
/// - video: A video.
/// - SeeAlso: ``EntryCategory``
public enum MediaContent: Sendable {
  /// A podcast episode.
  case podcast(PodcastEpisode)

  /// A video.
  case video(Video)
}

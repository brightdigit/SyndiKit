/// A struct representing an Atom category.
/// A struct representing the properties of a YouTube ID.
///
/// - Note: This struct conforms to the ``YouTubeID`` protocol.
///
/// - SeeAlso: ``YouTubeID``
///
/// - Important: This struct is internal.
///
/// - Parameters:
///   - videoID: The YouTube video ID.
///   - channelID: The YouTube channel ID.
/// - SeeAlso: ``EntryCategory``
internal struct YouTubeIDProperties: YouTubeID {
  internal let videoID: String
  internal let channelID: String

  /// A struct representing an Atom category.
  ///    Initializes a ``YouTubeIDProperties`` instance with the given AtomEntry.
  ///
  ///   - Parameters:
  ///     - entry: The AtomEntry containing the YouTube ID properties.
  ///
  ///   - Returns: A new ``YouTubeIDProperties`` instance,
  ///   or ``nil`` if the required properties are missing.
  /// - SeeAlso: ``EntryCategory``
  internal init?(entry: AtomEntry) {
    guard
      let channelID = entry.youtubeChannelID,
      let videoID = entry.youtubeVideoID else {
      return nil
    }
    self.channelID = channelID
    self.videoID = videoID
  }
}

/// A struct representing an Atom category.
/// A protocol abstracting the ID properties of a YouTube RSS Feed.
///
/// - Note: This protocol is public.
///
/// - SeeAlso: ``YouTubeIDProperties``
///
/// - Important: This protocol is specific to YouTube.
///
/// - Requires: Conforming types must provide a ``videoID`` and a ``channelID``.
/// - SeeAlso: ``EntryCategory``
public protocol YouTubeID {
  /// The YouTube video ID.
  var videoID: String { get }

  /// The YouTube channel ID.
  var channelID: String { get }
}

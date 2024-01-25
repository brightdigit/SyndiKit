internal struct YouTubeIDProperties: YouTubeID {
  internal let videoID: String

  internal let channelID: String

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

/// Specific type abstracting the id properties a YouTube RSS Feed.
/// ```xml
/// <yt:videoId>3hccNoPE59U</yt:videoId>
/// <yt:channelId>UCv75sKQFFIenWHrprnrR9aA</yt:channelId>
/// ```
public protocol YouTubeID {
  /// YouTube video ID.
  var videoID: String { get }

  /// YouTube channel ID.
  var channelID: String { get }
}

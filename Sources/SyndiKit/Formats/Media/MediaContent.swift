/**
 Represents different types of media content.

 - podcast: A podcast episode.
 - video: A video.
 */
public enum MediaContent {
  /// A podcast episode.
  case podcast(PodcastEpisode)

  /// A video.
  case video(Video)
}

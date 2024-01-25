/// A struct representing an Atom category.
/// An enumeration representing different types of videos.
/// - SeeAlso: `EntryCategory`
public enum Video {
  /// A video from YouTube.
  /// - Parameters:
  ///   - id: The ID of the YouTube video.
  case youtube(YouTubeID)
}

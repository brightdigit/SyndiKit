public struct YouTubeID: YouTubeIDProtocol {
  public let videoID: String

  public let channelID: String

  init?(entry: AtomEntry) {
    guard let channelID = entry.youtubeChannelID, let videoID = entry.youtubeVideoID else {
      return nil
    }
    self.channelID = channelID
    self.videoID = videoID
  }
}

import Foundation

/// <podcast:transcript
/// url="https://example.com/episode1/transcript.json"
/// type="application/json"
/// language="es"
/// rel="captions"
/// />
public struct PodcastTranscript: Codable {
  public enum MimeType: String, Codable {
    case pain = "text/plain"
    case html = "text/html"
    case srt = "text/srt"
    case vtt = "text/vtt"
    case json = "application/json"
    case subrip = "application/x-subrip"
  }

  public enum Relationship: String, Codable {
    case captions
  }

  public let url: URL
  public let type: MimeType
  public let language: String?
  public let rel: Relationship?

  enum CodingKeys: String, CodingKey {
    case url
    case type
    case language
    case rel
  }
}

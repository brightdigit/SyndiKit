import Foundation

/// <podcast:transcript
/// url="https://example.com/episode1/transcript.json"
/// type="application/json"
/// language="es"
/// rel="captions"
/// />
public struct PodcastTranscript: Codable {
  public enum TranscriptType: String, Codable {
    case pain = "text/plain"
    case html = "text/html"
    case srt = "text/srt"
    case vtt = "text/vtt"
    case json = "application/json"
    case subrip = "application/x-subrip"
  }

  public enum TranscriptRel: String, Codable {
    case rel = "captions"
  }

  public let url: URL
  public let type: TranscriptType
  public let language: String?
  public let rel: TranscriptRel?

  enum CodingKeys: String, CodingKey {
    case url
    case type
    case language
    case rel
  }
}

import Foundation

/// <podcast:transcript
/// url="https://example.com/episode1/transcript.json"
/// type="application/json"
/// language="es"
/// rel="captions"
/// />
public struct PodcastTranscript: Codable {
  public let url: URL
  public let type: String
  public let language: String?
  public let rel: String?

  enum CodingKeys: String, CodingKey {
    case url
    case type
    case language
    case rel
  }
}

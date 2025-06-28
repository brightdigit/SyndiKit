#if swift(>=5.7)
  @preconcurrency import Foundation
#else
  import Foundation
#endif
public struct Link: Codable, Sendable {
  public let href: URL
  public let rel: String?
}

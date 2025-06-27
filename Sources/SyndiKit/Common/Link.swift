import Foundation
public struct Link: Codable, Sendable {
  public let href: URL
  public let rel: String?
}

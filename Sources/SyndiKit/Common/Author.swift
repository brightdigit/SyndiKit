import Foundation

/// a person, corporation, or similar entity.
public struct Author: Codable, Equatable {
  /// Conveys a human-readable name for the person.
  public let name: String

  /// Contains an email address for the person.
  public let email: String?

  /// Contains a home page for the person.
  public let uri: URL?

  internal init(name: String) {
    self.name = name
    email = nil
    uri = nil
  }
}

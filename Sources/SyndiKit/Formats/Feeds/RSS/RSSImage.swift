#if swift(>=5.7)
@preconcurrency import Foundation
#else
import Foundation
#endif

/// Represents a GIF, JPEG, or PNG image.
public struct RSSImage: Codable, Sendable {
  /// The URL of the image.
  public let url: URL

  /// The title or description of the image.
  ///
  /// This is used in the ``alt`` attribute of the HTML `<img>` tag
  /// when the channel is rendered in HTML.
  public let title: String

  /// The URL of the site that the image links to.
  ///
  /// In practice, the image ``title`` and ``link`` should have
  /// the same value as the channel's ``title`` and ``link``.
  public let link: URL

  /// The width of the image in pixels.
  public let width: Int?

  /// The height of the image in pixels.
  public let height: Int?

  /// Additional description of the image.
  ///
  /// This text is included in the ``title`` attribute of the link
  /// formed around the image in the HTML rendering.
  public let description: String?
}

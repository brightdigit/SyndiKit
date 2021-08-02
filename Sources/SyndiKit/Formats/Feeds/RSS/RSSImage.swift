import Foundation

/// Specifies a GIF, JPEG or PNG image.
public struct RSSImage: Codable {
  /// The URL of a GIF, JPEG or PNG image
  public let url: URL

  /// Describes the image.
  ///
  /// It's used in the ALT attribute of the HTML <img> tag
  /// when the channel is rendered in HTML.
  public let title: String

  ///  The URL of the site, when the channel is rendered,
  ///  the image is a link to the site.
  ///
  ///  In practice the image <title> and <link> should have
  ///  the same value as the channel's <title> and <link>
  public let link: URL

  /// The width of the image in pixels.
  public let width: Int?

  /// The height of the image in pixels.
  public let height: Int?

  /// This contains text that is included in the TITLE attribute
  /// of the link formed around the image in the HTML rendering.
  public let description: String?
}

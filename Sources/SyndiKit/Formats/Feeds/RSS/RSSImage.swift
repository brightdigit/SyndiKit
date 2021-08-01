import Foundation

/// Specifies a GIF, JPEG or PNG image.
public struct RSSImage: Codable {
  /// the URL of a GIF, JPEG or PNG image
  public let url: URL

  /// describes the image, it's used in the ALT attribute of the HTML <img> tag when the channel is rendered in HTML.
  public let title: String

  ///  the URL of the site, when the channel is rendered, the image is a link to the site.
  ///
  ///  In practice the image <title> and <link> should have the same value as the channel's <title> and <link>
  public let link: URL

  /// the width of the image in pixels.
  public let width: Int?

  /// the height of the image in pixels.
  public let height: Int?

  /// contains text that is included in the TITLE attribute of the link formed around the image in the HTML rendering.
  public let description: String?
}

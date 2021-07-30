import Foundation

/// Basic abstract Feed
/// ## Topics
///
/// ### Basic Properties
///
/// - ``title``
/// - ``siteURL``
/// - ``summary``
/// - ``updated``
/// - ``author``
/// - ``copyright``
/// - ``image``
/// - ``children``
///
/// ### Special Properties
///
/// - ``youtubeChannelID``
/// - ``syndication``
public protocol Feedable {
  /// The name of the channel.
  var title: String { get }
  /// The URL to the website corresponding to the channel.
  var siteURL: URL? { get }
  /// Phrase or sentence describing the channel.
  var summary: String? { get }

  /// The last time the content of the channel changed.
  var updated: Date? { get }

  /// The author of the channel.
  var author: Author? { get }

  /// Copyright notice for content in the channel.
  var copyright: String? { get }

  /// Specifies a GIF, JPEG or PNG image that can be displayed with the channel.
  var image: URL? { get }

  /// Items or stories attached to the feed.
  var children: [Entryable] { get }

  /// For YouTube channels, this will be the youtube channel ID.
  var youtubeChannelID: String? { get }

  /// Provides syndication hints to aggregators and others
  var syndication: SyndicationUpdate? { get }
}

import Foundation

/// A builder for creating a site collection directory.
public struct SiteCollectionDirectoryBuilder: SiteDirectoryBuilder, Sendable {
  /// Initializes a new instance of ``SiteCollectionDirectoryBuilder``.
  public init() {}

  /// A struct representing an Atom category.
  ///   Creates a site collection directory from a site collection.
  ///
  ///   - Parameter blogs: The site collection to build the directory from.
  ///
  ///   - Returns: A new instance of ``SiteCollectionDirectory``.
  /// - SeeAlso: ``EntryCategory``
  public func directory(fromCollection blogs: SiteCollection) -> SiteCollectionDirectory {
    SiteCollectionDirectory(blogs: blogs)
  }
}

/// A protocol for building site directories.
public protocol SiteDirectoryBuilder: Sendable {
  /// The type of site directory to build.
  associatedtype SiteDirectoryType: SiteDirectory

  /// A struct representing an Atom category.
  ///   Creates a site directory from a site collection.
  ///
  ///   - Parameter blogs: The site collection to build the directory from.
  ///
  ///   - Returns: A new instance of ``SiteDirectoryType``.
  /// - SeeAlso: ``EntryCategory``
  func directory(fromCollection blogs: SiteCollection) -> SiteDirectoryType
}

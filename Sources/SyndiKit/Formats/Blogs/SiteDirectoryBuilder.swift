import Foundation

/// A builder for creating a site collection directory.
public struct SiteCollectionDirectoryBuilder: SiteDirectoryBuilder {
  /// Initializes a new instance of `SiteCollectionDirectoryBuilder`.
  public init() {}

  /**
   Creates a site collection directory from a site collection.

   - Parameter blogs: The site collection to build the directory from.

   - Returns: A new instance of `SiteCollectionDirectory`.
   */
  public func directory(fromCollection blogs: SiteCollection) -> SiteCollectionDirectory {
    SiteCollectionDirectory(blogs: blogs)
  }
}

/// A protocol for building site directories.
public protocol SiteDirectoryBuilder {
  /// The type of site directory to build.
  associatedtype SiteDirectoryType: SiteDirectory

  /**
   Creates a site directory from a site collection.

   - Parameter blogs: The site collection to build the directory from.

   - Returns: A new instance of `SiteDirectoryType`.
   */
  func directory(fromCollection blogs: SiteCollection) -> SiteDirectoryType
}

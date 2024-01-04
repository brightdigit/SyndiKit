import Foundation

public struct SiteCollectionDirectoryBuilder: SiteDirectoryBuilder {
  public init() {}
  public func directory(fromCollection blogs: SiteCollection) -> SiteCollectionDirectory {
    SiteCollectionDirectory(blogs: blogs)
  }
}

public protocol SiteDirectoryBuilder {
  associatedtype SiteDirectoryType: SiteDirectory
  func directory(fromCollection blogs: SiteCollection) -> SiteDirectoryType
}

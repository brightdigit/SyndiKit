import Foundation

public protocol SiteDirectoryBuilder {
  associatedtype SiteDirectoryType: SiteDirectory
  func directory(fromCollection blogs: SiteCollection) -> SiteDirectoryType
}

public struct SiteCollectionDirectoryBuilder: SiteDirectoryBuilder {
  public func directory(fromCollection blogs: SiteCollection) -> SiteCollectionDirectory {
    SiteCollectionDirectory(blogs: blogs)
  }
}

import Vapor

public protocol ConfiguratorProtocol {
  func configure(_ app: Application) throws
}

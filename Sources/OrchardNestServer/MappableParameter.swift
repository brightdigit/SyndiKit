import Fluent

enum MappableParameter: String {
  case category
  case channel
  case page
}

extension MappableParameter {
  func pathComponents(on database: Database, withViews views: [String], from eventLoop: EventLoop) -> EventLoopFuture<[String]> {
    switch self {
    case .channel:
      return Channel.query(on: database).field(\.$id).all().map { $0.compactMap { $0.id?.base32Encoded.lowercased() } }
    case .category:
      return Category.query(on: database).field(\.$id).all().map { $0.compactMap { $0.id }}
    case .page:
      return eventLoop.makeSucceededFuture(views)
    }
  }
}

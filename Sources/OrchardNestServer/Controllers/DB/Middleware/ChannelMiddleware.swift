import Fluent

struct ChannelMiddleware: ModelMiddleware {
  typealias Model = Channel

  func trim(model: Channel) -> Channel {
    model.title = model.title.trimmingCharacters(in: .whitespacesAndNewlines)
    model.author = model.author.trimmingCharacters(in: .whitespacesAndNewlines)
    model.subtitle = model.subtitle?.trimmingCharacters(in: .whitespacesAndNewlines)
    model.twitterHandle = model.twitterHandle?.trimmingCharacters(in: .whitespacesAndNewlines)

    return model
  }

  func create(model: Channel, on database: Database, next: AnyModelResponder) -> EventLoopFuture<Void> {
    next.create(trim(model: model), on: database)
  }

  func update(model: Channel, on database: Database, next: AnyModelResponder) -> EventLoopFuture<Void> {
    next.update(trim(model: model), on: database)
  }
}

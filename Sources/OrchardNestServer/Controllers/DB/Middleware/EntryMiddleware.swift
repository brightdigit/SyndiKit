import Fluent

struct EntryMiddleware: ModelMiddleware {
  typealias Model = Entry

  func trim(model: Entry) -> Entry {
    model.title = model.title.trimmingCharacters(in: .whitespacesAndNewlines)
    model.summary = model.summary.trimmingCharacters(in: .whitespacesAndNewlines)
    model.content = model.content?.trimmingCharacters(in: .whitespacesAndNewlines)

    return model
  }

  func create(model: Entry, on database: Database, next: AnyModelResponder) -> EventLoopFuture<Void> {
    return next.create(trim(model: model), on: database)
  }

  func update(model: Entry, on database: Database, next: AnyModelResponder) -> EventLoopFuture<Void> {
    return next.update(trim(model: model), on: database)
  }
}

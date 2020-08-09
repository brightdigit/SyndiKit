import Fluent
import Vapor

final class Category: Model {
  static var schema = "categories"

  init() {}

  init(slug: String) {
    id = slug
  }

  @ID(custom: "slug", generatedBy: .user)
  var id: String?
}

extension Category {
  static func from(_ slug: String, on database: Database) -> EventLoopFuture<Category> {
    Category.find(slug, on: database).flatMap { (langOpt) -> EventLoopFuture<Category> in
      let category: Category
      if let actual = langOpt {
        category = actual
      } else {
        category = Category(slug: slug)
      }
      return category.save(on: database).transform(to: category)
    }
  }
}

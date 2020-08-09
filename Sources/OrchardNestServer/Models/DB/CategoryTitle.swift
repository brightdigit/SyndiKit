import Fluent
import Vapor

final class CategoryTitle: Model {
  static var schema = "category_titles"

  init() {}

  init(id: UUID? = nil, language: Language, category: Category) throws {
    self.id = id
    $category.id = try category.requireID()
    $language.id = try language.requireID()
  }

  @ID()
  var id: UUID?

  @Parent(key: "code")
  var language: Language

  @Parent(key: "slug")
  var category: Category

  @Field(key: "title")
  var title: String
}

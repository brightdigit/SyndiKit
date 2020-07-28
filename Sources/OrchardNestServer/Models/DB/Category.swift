import Fluent
import Vapor

final class Category: Model {
  static var schema = "categories"

  init() {}

  @ID(custom: "slug", generatedBy: .user)
  var id: String?

  @Field(key: "title")
  var title: String
}

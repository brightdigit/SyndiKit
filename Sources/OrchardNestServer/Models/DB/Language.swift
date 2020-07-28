import Fluent
import Vapor

final class Language: Model {
  static var schema = "languages"

  init() {}

  @ID(custom: "code", generatedBy: .user)
  var id: String?

  @Field(key: "title")
  var title: String
}

import Vapor

struct RefreshCommand: Command {
  typealias Signature = RefreshConfiguration

  var help: String

  func run(using _: CommandContext, signature _: RefreshConfiguration) throws {}
}

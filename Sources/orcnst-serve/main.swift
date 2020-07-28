import OrchardNestServer
import Vapor

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }
try Configurator.shared.configure(app)
try app.run()

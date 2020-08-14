import Fluent
import FluentPostgresDriver
import Ink
import OrchardNestKit
import Plot
import QueuesFluentDriver
import Vapor
extension Date {
  func get(_ type: Calendar.Component) -> Int {
    let calendar = Calendar.current
    return calendar.component(type, from: self)
  }
}

extension HTML: ResponseEncodable {
  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    var headers = HTTPHeaders()
    headers.add(name: .contentType, value: "text/html")
    return request.eventLoop.makeSucceededFuture(.init(
      status: .ok, headers: headers, body: .init(string: render())
    ))
  }
}

struct OrganizedSite {
  let languageCode: String
  let categorySlug: String
  let site: Site
}

//
public final class Configurator: ConfiguratorProtocol {
  public static let shared: ConfiguratorProtocol = Configurator()

  //
  ///// Called before your application initializes.
  public func configure(_ app: Application) throws {
    // Register providers first
    // try services.register(FluentPostgreSQLProvider())
    // try services.register(AuthenticationProvider())

    // services.register(DirectoryIndexMiddleware.self)

    // Register middleware
    // var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(SessionsMiddleware.self) // Enables sessions.
    // let rootPath = Environment.get("ROOT_PATH") ?? app.directory.publicDirectory

//    app.webSockets = WebSocketRepository()
//
//    app.middleware.use(DirectoryIndexMiddleware(publicDirectory: rootPath))

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

//    // Configure Leaf
//    app.views.use(.leaf)
//    app.leaf.cache.isEnabled = app.environment.isRelease
//    app.middleware.use(ErrorMiddleware.default(environment: app.environment))
    // middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    // services.register(middlewares)

    // Configure a SQLite database
    let postgreSQLConfig: PostgresConfiguration

    if let url = Environment.get("DATABASE_URL") {
      postgreSQLConfig = PostgresConfiguration(url: url)!
    } else {
      postgreSQLConfig = PostgresConfiguration(hostname: "localhost", username: "orchardnest")
    }

    app.databases.use(.postgres(configuration: postgreSQLConfig, maxConnectionsPerEventLoop: 8, connectionPoolTimeout: .seconds(60)), as: .psql)
    app.migrations.add([
      CategoryMigration(),
      LanguageMigration(),
      CategoryTitleMigration(),
      ChannelMigration(),
      EntryMigration(),
      PodcastEpisodeMigration(),
      YouTubeChannelMigration(),
      YouTubeVideoMigration(),
      PodcastChannelMigration(),
      ChannelStatusMigration(),
      LatestEntriesMigration(),
      JobModelMigrate(schema: "queue_jobs")
    ])

    app.queues.configuration.refreshInterval = .seconds(25)
    app.queues.use(.fluent())

    app.queues.add(RefreshJob())
    app.queues.schedule(RefreshJob()).daily().at(.midnight)
    app.queues.schedule(RefreshJob()).daily().at(7, 30)
    app.queues.schedule(RefreshJob()).daily().at(19, 30)
    #if DEBUG
      if !app.environment.isRelease {
        let minute = Date().get(.minute)
        [0, 30].map { ($0 + minute + 5).remainderReportingOverflow(dividingBy: 60).partialValue }.forEach { minute in
          app.queues.schedule(RefreshJob()).hourly().at(.init(integerLiteral: minute))
        }
      }
    #endif
    try app.queues.startInProcessJobs(on: .default)
    app.commands.use(RefreshCommand(help: "Imports data into the database"), as: "refresh")

    try app.autoMigrate().wait()
    //   services.register(wss, as: WebSocketServer.self)

    let api = app.grouped("api", "v1")

    try app.register(collection: HTMLController(markdownDirectory: app.directory.viewsDirectory))
    try api.grouped("entires").register(collection: EntryController())
    try api.grouped("channels").register(collection: ChannelController())
    try api.grouped("categories").register(collection: CategoryController())

    app.post("jobs") { req in
      req.queue.dispatch(
        RefreshJob.self,
        RefreshConfiguration()
      ).map { HTTPStatus.created }
    }
  }
}

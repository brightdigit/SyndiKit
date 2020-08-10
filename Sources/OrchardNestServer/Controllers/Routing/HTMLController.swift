import Fluent
import FluentSQL
import Ink
import OrchardNestKit
import Plot
import Vapor

struct InvalidDatabaseError: Error {}

extension Node where Context == HTML.BodyContext {
  static func playerForPodcast(withAppleId appleId: Int) -> Self {
    .ul(
      .class("podcast-players"),
      .li(
        .a(
          .href("https://podcasts.apple.com/podcast/id\(appleId)"),
          .img(
            .src("/images/podcast-players/apple/icon.svg")
          ),
          .div(
            .div(
              .text("Listen on")
            ),
            .div(
              .class("name"),
              .text("Apple Podcasts")
            )
          )
        )
      ),
      .li(
        .a(
          .href("https://overcast.fm/itunes\(appleId)"),
          .img(
            .src("/images/podcast-players/overcast/icon.svg")
          ),
          .div(
            .div(
              .text("Listen on")
            ),
            .div(
              .class("name"),
              .text("Overcast")
            )
          )
        )
      ),
      .li(
        .a(
          .href("https://castro.fm/itunes/\(appleId)"),
          .img(
            .src("/images/podcast-players/castro/icon.svg")
          ),
          .div(
            .div(
              .text("Listen on")
            ),
            .div(
              .class("name"),
              .text("Castro")
            )
          )
        )
      ),
      .li(
        .a(
          .href("https://podcasts.apple.com/podcast/id\(appleId)"),
          .img(
            .src("/images/podcast-players/pocketcasts/icon.svg")
          ),
          .div(
            .div(
              .text("Listen on")
            ),
            .div(
              .class("name"),
              .text("Pocket Casts")
            )
          )
        )
      )
    )
  }
}

extension Node where Context == HTML.BodyContext {
  static func filters() -> Self {
    .nav(
      .class("posts-filter clearfix row"),
      .ul(
        .class("column"),
        .li(.a(.class("button"), .href("/"), .i(.class("el el-calendar")), .text(" Latest"))),
        .li(.a(.class("button"), .href("/category/development"), .i(.class("el el-cogs")), .text(" Development"))),
        .li(.a(.class("button"), .href("/category/marketing"), .i(.class("el el-bullhorn")), .text(" Marketing"))),
        .li(.a(.class("button"), .href("/category/design"), .i(.class("el el-brush")), .text(" Design"))),
        .li(.a(.class("button"), .href("/category/podcasts"), .i(.class("el el-podcast")), .text(" Podcasts"))),
        .li(.a(.class("button"), .href("/category/youtube"), .i(.class("el el-video")), .text(" YouTube"))),
        .li(.a(.class("button"), .href("/category/newsletters"), .i(.class("el el-envelope")), .text(" Newsletters")))
      )
    )
  }
}

extension Node where Context == HTML.BodyContext {
  static func header() -> Self {
    .header(
      .class("container"),
      .nav(
        .class("row"),
        .ul(
          .class("column"),
          .li(.a(.href("/"), .i(.class("el el-home")), .text(" Home"))),
          .li(.a(.href("/about"), .i(.class("el el-info-circle")), .text(" About"))),
          .li(.a(.href("/support"), .i(.class("el el-question-sign")), .text(" Support")))
        ),
        .ul(.class("float-right column"),
            .li(.a(.href("https://github.com/brightdigit/OrchardNest"), .i(.class("el el-github")), .text(" GitHub"))),
            .li(.a(.href("https://twitter.com/OrchardNest"), .i(.class("el el-twitter")), .text(" Twitter"))))
      ),
      .div(
        .class("row"),
        .h1(
          .class("column"),
          .img(
            .class("logo"),
            .src("/images/logo.svg")
          ),
          .text("&nbsp;OrchardNest")
        )
      ),
      div(
        .class("row"),
        .p(
          .class("tagline column"),
          .text("Swift Articles and News")
        )
      )
    )
  }
}

extension Node where Context == HTML.DocumentContext {
  static func head(withSubtitle subtitle: String, andDescription description: String) -> Self {
    return
      .head(
        .title("OrchardNest - \(subtitle)"),
        .meta(.charset(.utf8)),
        .meta(.name("viewport"), .content("width=device-width, initial-scale=1")),
        .meta(.name("description"), .content(description)),
        .raw("""
        <!-- Global site tag (gtag.js) - Google Analytics -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-GXSE03BMPF"></script>
        <script>
          window.dataLayer = window.dataLayer || [];
          function gtag(){dataLayer.push(arguments);}
          gtag('js', new Date());

          gtag('config', 'G-GXSE03BMPF');
        </script>
        """),
        .link(.rel(.preload), .href("https://fonts.googleapis.com/css2?family=Catamaran:wght@100;400;800&display=swap"), .attribute(named: "as", value: "style")),
        .link(.rel(.preload), .href("/styles/elusive-icons/css/elusive-icons.min.css"), .attribute(named: "as", value: "style")),
        .link(.rel(.appleTouchIcon), .sizes("180x180"), .href("/apple-touch-icon.png")),
        .link(.rel(.appleTouchIcon), .type("image/png"), .sizes("32x32"), .href("/favicon-32x32.png")),
        .link(.rel(.appleTouchIcon), .type("image/png"), .sizes("16x16"), .href("/favicon-16x16.png")),
        .link(.rel(.manifest), .href("/site.webmanifest")),
        .link(.rel(.maskIcon), .href("/safari-pinned-tab.svg"), .color("#5bbad5")),
        .meta(.name("msapplication-TileColor"), .content("#2b5797")),
        .meta(.name("theme-color"), .content("#ffffff")),
        .link(.rel(.stylesheet), .href("/styles/elusive-icons/css/elusive-icons.min.css")),
        .link(.rel(.stylesheet), .href("/styles/normalize.css")),
        .link(.rel(.stylesheet), .href("/styles/milligram.css")),
        .link(.rel(.stylesheet), .href("/styles/style.css")),
        .link(.rel(.stylesheet), .href("https://fonts.googleapis.com/css2?family=Catamaran:wght@100;400;800&display=swap"))
      )
  }
}

extension Node where Context == HTML.ListContext {
  static func li(forEntryItem item: EntryItem, formatDateWith formatter: DateFormatter) -> Self {
    return
      .li(
        .class("blog-post"),

        .a(
          .href(item.url),
          .class("title"),
          .h3(
            .i(.class("el el-\(item.category.elClass)")),

            .text(item.title)
          )
        ),
        .div(
          .class("publishedAt"),
          .text(formatter.string(from: item.publishedAt))
        ),
        .unwrap(item.youtubeID) {
          .div(
            .class("video-content"),
            .a(
              .href(item.url),
              .img(.src("https://img.youtube.com/vi/\($0)/mqdefault.jpg"))
            ),
            .iframe(
              .attribute(named: "data-src", value: "https://www.youtube.com/embed/" + $0),
              .allow("accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"),
              .allowfullscreen(true)
            )
          )

        },
        .div(
          .class("summary"),
          .text(item.summary.plainTextShort)
        ),
        .unwrap(item.podcastEpisodeURL) {
          .audio(
            .controls(true),
            .attribute(named: "preload", value: "none"),
            .source(
              .src($0)
            )
          )
        },
        .unwrap(item.channel.podcastAppleId) {
          .playerForPodcast(withAppleId: $0)
        },
        .div(
          .class("author"),
          .text("By "),
          .text(item.channel.author),
          .text(" at "),
          .a(
            .href("/channels/" + item.channel.id.base32Encoded.lowercased()),
            .text(item.channel.siteURL.host ?? item.channel.title)
          ),
          .unwrap(item.channel.twitterHandle) {
            .a(
              .href("https://twitter.com/\($0)"),
              .class("button twitter-handle"),
              .i(.class("el el-twitter")),
              .text(" @\($0)")
            )
          }
        ),
        .div(
          .class("social-share clearfix"),
          .text("Share"),
          .ul(
            .li(
              .a(
                .class("button"),
                .href(item.twitterShareLink),
                .i(.class("el el-twitter")),
                .text(" Tweet")
              )
            )
          )
        )
      )
  }
}

extension String {
  var plainTextShort: String {
    var result: String

    result = trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    guard result.count > 240 else {
      return result
    }
    return result.prefix(240).components(separatedBy: " ").dropLast().joined(separator: " ").appending("...")
  }
}

extension EntryCategoryType {
  var elClass: String {
    switch self {
    case .companies:
      return "website"
    case .design:
      return "brush"
    case .development:
      return "cogs"
    case .marketing:
      return "bullhorn"
    case .newsletters:
      return "envelope"
    case .podcasts:
      return "podcast"
    case .updates:
      return "file-new"
    case .youtube:
      return "video"
    }
  }
}

extension EntryCategory {
  var elClass: String {
    return type.elClass
  }
}

struct HTMLController {
  let views: [String: Markdown]
  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .medium
    return formatter
  }()

  init(views: [String: Markdown]?) {
    self.views = views ?? [String: Markdown]()
  }

  func category(req: Request) throws -> EventLoopFuture<HTML> {
    guard let category = req.parameters.get("category") else {
      throw Abort(.notFound)
    }

    return Entry.query(on: req.db)
      .with(\.$channel) { builder in
        builder.with(\.$podcasts).with(\.$youtubeChannels)
      }
      .join(parent: \.$channel)
      .with(\.$podcastEpisodes)
      .join(children: \.$podcastEpisodes, method: .left)
      .with(\.$youtubeVideos)
      .join(children: \.$youtubeVideos, method: .left)
      .filter(Channel.self, \Channel.$category.$id == category)
      .filter(Channel.self, \Channel.$language.$id == "en")
      .sort(\.$publishedAt, .descending)
      .limit(32)
      .all()
      .flatMapThrowing { (entries) -> [Entry] in
        guard entries.count > 0 else {
          throw Abort(.notFound)
        }
        return entries
      }
      .flatMapEachThrowing {
        try EntryItem(entry: $0)
      }
      .map { (items) -> HTML in
        HTML(
          .head(withSubtitle: "Swift Articles and News", andDescription: "Swift Articles and News of Category \(category)"),
          .body(
            .header(),
            .main(
              .class("container"),
              .filters(),
              .section(
                .class("row"),
                .ul(
                  .class("articles column"),
                  .forEach(items) {
                    .li(forEntryItem: $0, formatDateWith: Self.dateFormatter)
                  }
                )
              )
            )
          )
        )
      }
  }

  func page(req: Request) -> EventLoopFuture<HTML> {
    guard let name = req.parameters.get("page") else {
      return req.eventLoop.makeFailedFuture(Abort(.notFound))
    }

    guard let view = views[name] else {
      return req.eventLoop.makeFailedFuture(Abort(.notFound))
    }

    let html = HTML(
      .head(withSubtitle: "Support and FAQ", andDescription: view.metadata["description"] ?? name),
      .body(
        .header(),
        .main(
          .class("container"),
          .filters(),
          .section(
            .class("row"),
            .raw(view.html)
          )
        )
      )
    )

    return req.eventLoop.future(html)
  }

  func channel(req: Request) throws -> EventLoopFuture<HTML> {
    guard let channel = req.parameters.get("channel").flatMap({ $0.base32UUID }) else {
      throw Abort(.notFound)
    }

    return Entry.query(on: req.db)
      .with(\.$channel) { builder in
        builder.with(\.$podcasts).with(\.$youtubeChannels)
      }
      .join(parent: \.$channel)
      .with(\.$podcastEpisodes)
      .join(children: \.$podcastEpisodes, method: .left)
      .with(\.$youtubeVideos)
      .join(children: \.$youtubeVideos, method: .left)
      .filter(Channel.self, \Channel.$id == channel)
      .sort(\.$publishedAt, .descending)
      .limit(32)
      .all()
      .flatMapEachThrowing {
        try EntryItem(entry: $0)
      }
      .map { (items) -> HTML in
        HTML(
          .head(withSubtitle: "Swift Articles and News", andDescription: "Swift Articles and News"),
          .body(
            .header(),
            .main(
              .class("container"),
              .filters(),
              .section(
                .class("row"),
                .ul(
                  .class("articles column"),
                  .forEach(items) {
                    .li(forEntryItem: $0, formatDateWith: Self.dateFormatter)
                  }
                )
              )
            )
          )
        )
      }
  }

  func index(req: Request) -> EventLoopFuture<HTML> {
    return Entry.query(on: req.db).join(LatestEntry.self, on: \Entry.$id == \LatestEntry.$id)
      .with(\.$channel) { builder in
        builder.with(\.$podcasts).with(\.$youtubeChannels)
      }
      .join(parent: \.$channel)
      .with(\.$podcastEpisodes)
      .join(children: \.$podcastEpisodes, method: .left)
      .with(\.$youtubeVideos)
      .join(children: \.$youtubeVideos, method: .left)
      .filter(Channel.self, \Channel.$category.$id != "updates")
      .filter(Channel.self, \Channel.$language.$id == "en")
      .sort(\.$publishedAt, .descending)
      .limit(32)
      .all()
      .flatMapEachThrowing {
        try EntryItem(entry: $0)
      }
      .map { (items) -> HTML in
        HTML(
          .head(withSubtitle: "Swift Articles and News", andDescription: "Swift Articles and News"),
          .body(
            .header(),
            .main(
              .class("container"),
              .filters(),
              .section(
                .class("row"),
                .ul(
                  .class("articles column"),
                  .forEach(items) {
                    .li(forEntryItem: $0, formatDateWith: Self.dateFormatter)
                  }
                )
              )
            )
          )
        )
      }
  }
}

extension HTMLController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    routes.get("", use: index)
    routes.get("category", ":category", use: category)
    routes.get(":page", use: page)
    routes.get("channels", ":channel", use: channel)
  }
}

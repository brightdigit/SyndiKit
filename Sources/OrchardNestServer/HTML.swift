import Foundation
import OrchardNestKit
import Plot
import Vapor

extension HTML: ResponseEncodable {
  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    var headers = HTTPHeaders()
    headers.add(name: .contentType, value: "text/html")
    return request.eventLoop.makeSucceededFuture(.init(
      status: .ok, headers: headers, body: .init(string: render())
    ))
  }
}

public extension Node where Context == HTML.BodyContext {
  static func playerForPodcast(withAppleId appleId: Int) -> Self {
    .ul(
      .class("podcast-players"),
      .li(
        .a(
          .target(.blank),
          .href("https://podcasts.apple.com/podcast/id\(appleId)"),
          .img(
            .src("/images/podcast-players/apple/icon.svg"),
            .alt("Listen on Apple Podcasts")
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
          .target(.blank),
          .href("https://overcast.fm/itunes\(appleId)"),
          .img(
            .src("/images/podcast-players/overcast/icon.svg"),
            .alt("Listen on Overcast")
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
          .target(.blank),
          .href("https://castro.fm/itunes/\(appleId)"),
          .img(
            .src("/images/podcast-players/castro/icon.svg"),
            .alt("Listen on Castro")
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
          .target(.blank),
          .href("https://podcasts.apple.com/podcast/id\(appleId)"),
          .img(
            .src("/images/podcast-players/pocketcasts/icon.svg"),
            .alt("Listen on Pocket Casts")
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

public extension Node where Context == HTML.BodyContext {
  static func filters() -> Self {
    .nav(
      .class("posts-filter clearfix row"),
      .ul(
        .class("column"),
        .li(.a(.class("button"), .href("/"), .i(.class("el el-calendar")), .text(" Latest"))),
        .li(.a(.class("button"), .href("/categories/development"), .i(.class("el el-cogs")), .text(" Development"))),
        .li(.a(.class("button"), .href("/categories/marketing"), .i(.class("el el-bullhorn")), .text(" Marketing"))),
        .li(.a(.class("button"), .href("/categories/design"), .i(.class("el el-brush")), .text(" Design"))),
        .li(.a(.class("button"), .href("/categories/podcasts"), .i(.class("el el-podcast")), .text(" Podcasts"))),
        .li(.a(.class("button"), .href("/categories/youtube"), .i(.class("el el-video")), .text(" YouTube"))),
        .li(.a(.class("button"), .href("/categories/newsletters"), .i(.class("el el-envelope")), .text(" Newsletters")))
      )
    )
  }
}

public extension Node where Context == HTML.BodyContext {
  static func header() -> Self {
    .header(
      .class("container"),
      .nav(
        .class("row"),
        .ul(
          .class("column"),
          .li(.a(.href("/"), .i(.class("el el-home")), .text(" Home"))),
          .li(.a(.href("/about"), .i(.class("el el-info-circle")), .text(" About"))),
          .li(.a(.href("/support"), .i(.class("el el-question-sign")), .text(" Support"))),
          .li(.a(.href("https://iosdevdirectory.com/contributing"), .target(.blank), .i(.class("el el-plus-sign")), .text(" Add a Site")))
        ),
        .ul(.class("float-right column"),
            .li(.a(.href("https://github.com/brightdigit/OrchardNest"), .target(.blank), .i(.class("el el-github")), .text(" GitHub"))),
            .li(.a(.href("https://twitter.com/OrchardNest"), .target(.blank), .i(.class("el el-twitter")), .text(" Twitter"))))
      ),
      .div(
        .class("row"),
        .h1(
          .class("column"),
          .img(
            .class("logo"),
            .src("/images/logo.svg"),
            .alt("OrchardNest")
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

public extension Node where Context == HTML.DocumentContext {
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
        .link(
          .rel(.preload),
          .href("https://fonts.googleapis.com/css2?family=Catamaran:wght@100;400;800&display=swap"),
          .attribute(named: "as", value: "style")
        ),
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

public extension Node where Context == HTML.BodyContext {
  static func year(fromDate date: Date = Date()) -> Self {
    text(HTMLController.yearFormatter.string(from: date))
  }
}

public extension Node where Context == HTML.BodyContext {
  static func footer() -> Self {
    return footer(
      .class("container"),
      .div(
        .class("row"),
        .span(
          .class("column"),
          .hr(),
          .span(
            .text("Site Designed and Maintained by "),
            .a(
              .target(.blank),
              .href("https://twitter.com/leogdion"),
              .text("Leo Dion. ")
            )
          ),
          .span(
            .a(
              .target(.blank),
              .href("https://brightdigit.com"),
              .text("Bright Digit, LLC")
            ),
            .text(". Copyright ©"),
            .year(),
            .text(". ")
          ),
          .span(
            .a(
              .href("/privacy-policy"),
              .text("Privacy Policy")
            )
          )
        )
      )
    )
  }
}

public extension Node where Context == HTML.ListContext {
  static func li(forEntryItem item: EntryItem, formatDateWith formatter: DateFormatter) -> Self {
    return
      .li(
        .class("blog-post"),
        .id("entry-\(item.id.base32Encoded)"),
        .a(
          .href(item.url),
          .target(.blank),
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
        .unwrap(item.seconds) {
          .div(
            .class("length"),
            .text($0.positionalTime)
          )
        },
        .unwrap(item.youtubeID, {
          .div(
            .class("video-content"),
            .a(
              .href(item.url),
              .target(.blank),
              .img(
                .src("https://img.youtube.com/vi/\($0)/mqdefault.jpg"),
                .alt(item.title)
              )
            ),
            .iframe(
              .attribute(named: "data-src", value: "https://www.youtube.com/embed/" + $0),
              .allow("accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"),
              .allowfullscreen(true)
            )
          )

        }, else:
        .unwrap(item.fallbackImageURL) {
          .div(
            .class("featured-image"),
            .style("background-image: url(\($0));"),
            .attribute(named: "title", value: item.title)
          )
        }),
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
              .target(.blank),
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
                .target(.blank),
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

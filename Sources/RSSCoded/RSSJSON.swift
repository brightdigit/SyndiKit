import Foundation

struct RSSItem: Codable {
  let title: String
  let link: URL
  let description: String
  let guid: RSSGUID
}

struct RSSAuthor: Codable {
  let name: String
}

struct RSSChannel: Codable {
  let title: String
  let link: URL
  let description: String?
  let item: RSSItem
}

struct RSS: Codable {
  let channel: RSSChannel
}

struct RSSJSON: Codable {
  let version: URL
  let title: String
  let homePageUrl: URL
  let description: String?
  let author: RSSAuthor?
  let items: [RSSJSONItem]
}

enum RSSGUID: Codable {
  case url(URL)
  case uuid(UUID)
  case path([String])
  case string(String)

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let string = try container.decode(String.self)
    if let url = URL(string: string) {
      self = .url(url)
    } else if let uuid = UUID(uuidString: string) {
      self = .uuid(uuid)
    } else {
      let components = string.components(separatedBy: ":")
      if components.count > 1 {
        self = .path(components)
      } else {
        self = .string(string)
      }
    }
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    let string: String
    switch self {
    case let .url(url):
      string = url.absoluteString
    case let .uuid(uuid):
      string = uuid.uuidString.lowercased()
    case let .path(components):
      string = components.joined(separator: ":")
    case let .string(value):
      string = value
    }
    try container.encode(string)
  }
}

struct RSSJSONItem: Codable {
  let guid: RSSGUID
  let url: URL
  let title: String
  let contentHtml: String?
  let summary: String?
  let datePublished: Date?
  let author: RSSAuthor?
//  {
//    "guid": "https://www.donnywals.com/?p=1686",
//    "url": "https://www.donnywals.com/an-introduction-to-synchronizing-access-with-swifts-actors/",
//    "title": "An introduction to synchronizing access with Swift’s Actors",
//    "content_html": "<p>We all know that async / await was one of this year&rsquo;s big announcements WWDC. It completely changes the way we interact with concurrent code. Instead of using completion handlers, we can await results in a non-blocking way. More importantly, with the new Swift Concurrency features, our Swift code is much safer and consistent than ever before. For example, the Swift team built an all-new threading...</p>\n<p><a href=\"https://www.donnywals.com/an-introduction-to-synchronizing-access-with-swifts-actors/\" rel=\"nofollow\">Source</a></p>",
//    "summary": "We all know that async / await was one of this year’s big announcements WWDC. It completely changes the way we interact with concurrent code. Instead of using completion handlers, we can await results in a non-blocking way. More importantly, with the new Swift Concurrency features, our Swift code is [&#8230;]",
//    "date_published": "2021-06-14T19:29:29.000Z",
//    "author": {
//      "name": "donnywals"
//    }
//  },

//  {
//    "guid": "yt:video:QrTChgzseVk",
//    "url": "https://www.youtube.com/watch?v=QrTChgzseVk",
//    "title": "SwiftUI Login Screen Workflow",
//    "date_published": "2021-06-20T13:44:57.000Z",
//    "author": {
//      "name": "Stewart Lynch"
//    }
//  },

//  {
//    "guid": "https://swiftpackageindex.com/GraphQLSwift/Graphiti",
//    "url": "https://swiftpackageindex.com/GraphQLSwift/Graphiti",
//    "title": "Graphiti - 0.26.0",
//    "content_html": "<div><p><a href=\"https://swiftpackageindex.com/GraphQLSwift/Graphiti\">Graphiti</a><small> – <a href=\"https://github.com/GraphQLSwift/Graphiti/releases/tag/0.26.0\">Version 0.26.0 release notes. </a></small></p><div><p>Merge pull request <a class=\"issue-link js-issue-link\" data-error-text=\"Failed to load title\" data-id=\"923041202\" data-permission-text=\"Title is private\" data-url=\"https://github.com/GraphQLSwift/Graphiti/issues/64\" data-hovercard-type=\"pull_request\" data-hovercard-url=\"/GraphQLSwift/Graphiti/pull/64/hovercard\" href=\"https://github.com/GraphQLSwift/Graphiti/pull/64\">#64</a> from NeedleInAJayStack/preserveResultOrder</p>\n<ul>\n<li>Preserves result order: The returned object has field results in the same order as the query</li>\n</ul></div><small><a href=\"https://swiftpackageindex.com/GraphQLSwift/Graphiti\">GraphQLSwift/Graphiti</a></small></div>",
//    "summary": "<div><p><a href=\"https://swiftpackageindex.com/GraphQLSwift/Graphiti\">Graphiti</a><small> – <a href=\"https://github.com/GraphQLSwift/Graphiti/releases/tag/0.26.0\">Version 0.26.0 release notes. </a></small></p><p>The Swift GraphQL Schema framework for macOS and Linux</p><small><a href=\"https://swiftpackageindex.com/GraphQLSwift/Graphiti\">GraphQLSwift/Graphiti</a></small></div>",
//    "date_published": "2021-06-21T16:20:28.000Z"
//  },

//  {
//    "guid": "https://ideveloper.castos.com/podcasts/17340/episodes/297-there-we39ve-talked-about-software",
//    "url": "https://ideveloper.castos.com/podcasts/17340/episodes/297-there-we39ve-talked-about-software",
//    "title": "297 - There, We've Talked About Software",
//    "content_html": "<p>This week the boys talk the possible return to a new 'normal' and how companies like Apple might evolve, especially with the future of WWDC. Johns work on dynamically sized cells for low vision users and the evolution of accessibility. Scotty shares his client work hiatus to better focus on MoneyWell.</p>\r\n<p>James Dempsey &amp; The Breakpoints:</p>\r\n<p><a href=\"https://www.youtube.com/watch?v=9pp3LjPTDsY\" target=\"_blank\" rel=\"noopener\">Write To The Metal</a></p>\r\n<p><a href=\"https://youtu.be/xLpw4QTqD54\" target=\"_blank\" rel=\"noopener\">Liki Song Rehearsal</a></p>\r\n<p><a href=\"https://youtu.be/g7o1WY6PXR8\" target=\"_blank\" rel=\"noopener\">Liki Song Crowd Singalong</a></p>\r\n<p><a href=\"https://youtu.be/GRkjPvuyIOE\" target=\"_blank\" rel=\"noopener\">Almost Dropped My iPhone</a></p>",
//    "summary": "<p>This week the boys talk the possible return to a new 'normal' and how companies like Apple might evolve, especially with the future of WWDC. Johns work on dynamically sized cells for low vision users and the evolution of accessibility. Scotty shares his client work hiatus to better focus on MoneyWell.</p>\r\n<p>James Dempsey &amp; The Breakpoints:</p>\r\n<p><a href=\"https://www.youtube.com/watch?v=9pp3LjPTDsY\" target=\"_blank\" rel=\"noopener\">Write To The Metal</a></p>\r\n<p><a href=\"https://youtu.be/xLpw4QTqD54\" target=\"_blank\" rel=\"noopener\">Liki Song Rehearsal</a></p>\r\n<p><a href=\"https://youtu.be/g7o1WY6PXR8\" target=\"_blank\" rel=\"noopener\">Liki Song Crowd Singalong</a></p>\r\n<p><a href=\"https://youtu.be/GRkjPvuyIOE\" target=\"_blank\" rel=\"noopener\">Almost Dropped My iPhone</a></p>",
//    "date_published": "2021-06-17T14:00:00.000Z",
//    "author": {
//      "name": "Steve Scott (Scotty) & John Fox"
//    }
//  },
}

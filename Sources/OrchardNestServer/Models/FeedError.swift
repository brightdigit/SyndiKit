import Foundation

enum FeedError: Error {
  case download(URL, Error)
  case empty(URL)
  case parser(URL, Error)
  case items(URL)
  case invalidParent(URL, String)

  var localizedDescription: String {
    switch self {
    case let .download(url, error):
      return "\(url), download, \"\(error)\""
    case let .empty(url):
      return "\(url), empty"
    case let .invalidParent(url, parent):
      return "\(url), parent, \(parent)"
    case let .items(url):
      return "\(url), items"
    case let .parser(url, error):
      return "\(url), parser, \"\(error)\""
    }
  }
}

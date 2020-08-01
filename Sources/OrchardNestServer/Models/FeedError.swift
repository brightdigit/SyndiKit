import Foundation

enum FeedError: Error {
  case download(URL, Error)
  case empty(URL)
  case parser(URL, Error)
  case items(URL)
  case invalidParent(URL, String)
}

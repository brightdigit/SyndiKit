import Foundation
let urls = """
https://swiftpackageindex.com/releases.rss
https://mjtsai.com/blog/feed/
http://feeds.ideveloper.co/ideveloperpodcast.xml
http://www.mokacoding.com/feed.xml
https://www.it-guy.com/podcasts/ajtm_feed.xml.rss
https://developer.apple.com/news/rss/news.rss
https://wwdcnotes.com/feed.rss
https://developer.apple.com/news/releases/rss/releases.rss
https://www.relay.fm/radar/feed
https://www.swiftbysundell.com/posts?format=RSS
https://swiftweeklybrief.com/feed.xml
https://cocoacasts.com/feed
https://www.fivestars.blog/feed.xml
https://www.raywenderlich.com/feed/podcast
https://feeds.transistor.fm/empowerapps-show
https://www.andyibanez.com/tags/apple/index.xml
http://ios-goodies.com/rss
https://blog.timac.org/index.xml
https://www.revenuecat.com/blog/rss.xml
https://atomicbird.com/index.xml
http://www.enekoalonso.com/feed.xml
https://iosdevweekly.com/issues.rss
https://www.avanderlee.com/feed/
https://mecid.github.io/feed.xml
https://rhonabwy.com/feed/
https://www.hackingwithswift.com/articles/rss
https://www.advancedswift.com/rss
https://www.donnywals.com/feed/
https://www.youtube.com/feeds/videos.xml?channel_id=UC7AuV86ZjR3YaEdb5USNvWQ
https://www.youtube.com/feeds/videos.xml?channel_id=UCfvk5lomVsbHBYWciRVNHlg
https://www.youtube.com/feeds/videos.xml?channel_id=UCjkoQk5fOk6lH-shlm53vlw
https://www.youtube.com/feeds/videos.xml?channel_id=UCOWdR4sFkmolWkU2fg669Gg
https://www.youtube.com/feeds/videos.xml?channel_id=UCv75sKQFFIenWHrprnrR9aA
""".components(separatedBy: .whitespacesAndNewlines).compactMap(URL.init(string:))

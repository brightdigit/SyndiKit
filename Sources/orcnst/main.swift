import Foundation
import OrchardNest



let blogs = URL(string: "https://raw.githubusercontent.com/daveverwer/iOSDevDirectory/master/blogs.json")!

let reader = BlogReader()
let sites = try reader.sites(fromURL: blogs)
debugPrint(sites)

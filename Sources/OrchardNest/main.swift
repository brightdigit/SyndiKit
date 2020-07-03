import Foundation
import PromiseKit

struct InvalidURL : Error {
    let url : URL
}
let opmlUrls = [
    "https://iosdevdirectory.com/opml/en/updates.opml",
"https://iosdevdirectory.com/opml/en/development.opml",
"https://iosdevdirectory.com/opml/en/design.opml",
"https://iosdevdirectory.com/opml/en/podcasts.opml",
"https://iosdevdirectory.com/opml/en/marketing.opml",
"https://iosdevdirectory.com/opml/en/podcasts.opml",
    "https://iosdevdirectory.com/opml/en/newsletters.opml",
"https://iosdevdirectory.com/opml/en/youtube.opml"
].compactMap(URL.init(string:))

let blogs = URL(string: "https://raw.githubusercontent.com/daveverwer/iOSDevDirectory/master/blogs.json")!

var metadata = [ String : Set<String>]()

let queue = DispatchQueue(label: "metadata", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
public class ParserDelegate : NSObject, XMLParserDelegate {
    let names = ["entry", "item"]
    var elements = [String]()
    let onEnd : () -> Void

    public init(_ end: @escaping () -> Void) {
        self.onEnd = end
        super.init()
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        self.onEnd()
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if let parent = self.elements.last {
            print(parent, elementName)
            if names.contains(parent) {
                queue.async(flags: .barrier) {
                    
                    var attributes = metadata[elementName] ?? Set<String>()
                    attributes.formUnion(attributeDict.keys)
                    metadata[elementName] = attributes
                    print(elementName, attributes)
                }
            }
        }
        self.elements.append(elementName)
    }
    
    
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.elements.removeLast()
    }
}

public class OPMLParserDelegate : NSObject, XMLParserDelegate {
    var urls = [URL]()
    let onEnd : ([URL]) -> Void
    public init(_ end: @escaping ([URL]) -> Void) {
        self.onEnd = end
        super.init()
    }
    public func parserDidEndDocument(_ parser: XMLParser) {
        self.onEnd(self.urls)
    }
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if let xmlURL = attributeDict["xmlUrl"].flatMap(URL.init(string:)), elementName == "outline" {
            debugPrint(xmlURL)
            urls.append(xmlURL)
        }
    }
}

var delegates = [XMLParserDelegate]()

let promises = opmlUrls.map{ url in
    
    return Promise<Data> { (resolver) in
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            resolver.resolve(data, error)
        }
        task.resume()
        
    }.then { (data) in
        Promise<[URL]>{ (resolver) in
            
            let parser = XMLParser(data: data)
            let delegate = OPMLParserDelegate { (urls) in
                resolver.fulfill(urls)
            }
            parser.delegate = delegate
            delegates.append(delegate)
            parser.parse()
        }
    }.then { (urls) -> Promise<Void> in
            let promises = urls.map{ (url) in
                Promise<Void>{ (resolver) in
                    
                    guard let parser = XMLParser(contentsOf: url) else {
                        debugPrint("failed",url)
                        resolver.reject(InvalidURL(url: url))
                        return
                    }
                    let delegate = ParserDelegate {
                        resolver.fulfill()
                    }
                    parser.delegate = delegate
                    delegates.append(delegate)
                    parser.parse()
                }
            }
        return when(fulfilled: promises)
    }
}
//
//.then { (data) -> Thenable in
//    return Promise<[URL]>{ (resolver) in
//        let parser = XMLParser(data: data)
//        let delegate = OPMLParserDelegate({
//            resolver.fulfill($0)
//        })
//        parser.delegate = delegate
//        delegates.append(delegate)
//        parser.parse()
//    }
//}.then { (urls) -> Thenable in
//    let promises = urls.map{ (url) in
//        Promise<Void>{ (resolver) in
//            let parser = XMLParser(contentsOf: url)
//            let delegate = ParserDelegate {
//                resolver.fulfill()
//            }
//            parser.delegate = delegate
//            delegates.append(delegate)
//            parser.parse()
//        }
//    }
//
//    return when(fulfilled: promises)
//}
var done = false

PromiseKit.when(resolved: promises).done { (results) in
    print(metadata)
    done = true
}
while !done {
    RunLoop.main.run(until: .distantPast)
}




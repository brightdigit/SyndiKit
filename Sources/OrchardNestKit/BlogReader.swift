import Foundation

public class BlogReader {
  public init() {}

  public func sites(fromURL url: URL) throws -> [LanguageContent] {
    let decoder = JSONDecoder()
    let data = try Data(contentsOf: url)
    return try decoder.decode([LanguageContent].self, from: data)
  }
}

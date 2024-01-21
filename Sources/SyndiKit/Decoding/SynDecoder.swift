import Foundation
import XMLCoder

/// An object that decodes instances of Feedable from JSON or XML objects.
/// ## Topics
///
/// ### Creating a Decoder
///
/// - ``init()``
///
/// ### Decoding
///
/// - ``decode(_:)``
public class SynDecoder {
  private static let defaultTypes: [DecodableFeed.Type] = [
    RSSFeed.self,
    AtomFeed.self,
    JSONFeed.self
  ]

  private let defaultJSONDecoderSetup: (JSONDecoder) -> Void
  private let defaultXMLDecoderSetup: (XMLDecoder) -> Void
  private let types: [DecodableFeed.Type]

  private lazy var defaultXMLDecoder: XMLDecoder = {
    let decoder = XMLDecoder()
    self.defaultXMLDecoderSetup(decoder)
    return decoder
  }()

  private lazy var defaultJSONDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    self.defaultJSONDecoderSetup(decoder)
    return decoder
  }()

  private lazy var decodings: [DecoderSource: [String: AnyDecoding]] = {
    let decodings = types.map { type -> (DecoderSource, AnyDecoding) in
      let source = type.source
      let setup = type.source as? CustomDecoderSetup
      let decoder: TypeDecoder

      switch (source.source, setup?.setup(decoder:)) {
      case let (.xml, .some(setup)):
        decoder = XMLDecoder()
        setup(decoder)

      case let (.json, .some(setup)):
        decoder = JSONDecoder()
        setup(decoder)

      case (.xml, .none):
        decoder = self.defaultXMLDecoder

      case (.json, .none):
        decoder = self.defaultJSONDecoder
      }

      return (source.source, type.anyDecoding(using: decoder))
    }
    return Dictionary(grouping: decodings) { $0.0 }
      .mapValues { $0
        .map { $0.1 }
        .map { (type(of: $0).label, $0) }
      }
      .mapValues(Dictionary.init(uniqueKeysWithValues:))
  }()

  internal init(
    types: [DecodableFeed.Type]? = nil,
    defaultJSONDecoderSetup: ((JSONDecoder) -> Void)? = nil,
    defaultXMLDecoderSetup: ((XMLDecoder) -> Void)? = nil
  ) {
    self.types = types ?? Self.defaultTypes
    self.defaultJSONDecoderSetup = defaultJSONDecoderSetup ?? Self.setupJSONDecoder(_:)
    self.defaultXMLDecoderSetup = defaultXMLDecoderSetup ?? Self.setupXMLDecoder(_:)
  }

  /// Creates an instance of `RSSDecoder`
  public convenience init() {
    self.init(types: nil, defaultJSONDecoderSetup: nil, defaultXMLDecoderSetup: nil)
  }

  internal static func setupJSONDecoder(_ decoder: JSONDecoder) {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .custom(DateFormatterDecoder.RSS.decoder.decode(from:))
  }

  internal static func setupXMLDecoder(_ decoder: XMLDecoder) {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .custom(DateFormatterDecoder.RSS.decoder.decode(from:))
    decoder.trimValueWhitespaces = false
  }

  /// Returns a `Feedable` object of the type you specify, decoded from a JSON object.
  /// - Parameter data: The JSON or XML object to decode.
  /// - Returns: A `Feedable` object
  ///
  /// If the data is not valid RSS, this method throws the
  /// `DecodingError.dataCorrupted(_:)` error.
  /// If a value within the RSS fails to decode,
  /// this method throws the corresponding error.
  ///
  /// ```swift
  /// let data = Data(contentsOf: "empowerapps-show.xml")!
  /// let decoder = SynDecoder()
  /// let feed = try decoder.decode(data)
  ///
  /// print(feed.title) // Prints "Empower Apps"
  /// ```
  public func decode(_ data: Data) throws -> Feedable {
    var errors = [String: DecodingError]()

    guard let firstByte = data.first else {
      throw DecodingError.dataCorrupted(
        .init(codingPath: [], debugDescription: "Empty Data.")
      )
    }
    guard let source = DecoderSource(rawValue: firstByte) else {
      throw DecodingError.dataCorrupted(
        .init(codingPath: [], debugDescription: "Unmatched First Byte: \(firstByte)")
      )
    }
    guard let decodings = decodings[source] else {
      throw DecodingError.failedAttempts(errors)
    }
    for (label, decoding) in decodings {
      do {
        return try decoding.decodeFeed(data: data)
      } catch let decodingError as DecodingError {
        errors[label] = decodingError
      }
    }

    throw DecodingError.failedAttempts(errors)
  }
}

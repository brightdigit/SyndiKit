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
public final class SynDecoder: @unchecked Sendable {
  private static let defaultTypes: [DecodableFeed.Type] = [
    RSSFeed.self,
    AtomFeed.self,
    JSONFeed.self
  ]

  private let defaultJSONDecoderSetup: @Sendable(JSONDecoder) -> Void
  private let defaultXMLDecoderSetup: @Sendable(XMLDecoder) -> Void
  private let types: [DecodableFeed.Type]

  private let defaultXMLDecoder: XMLDecoder

  private let defaultJSONDecoder: JSONDecoder

  // swiftlint:disable:next closure_body_length
  private let decodings: [DecoderSource: [String: AnyDecoding]]

  internal init(
    types: [DecodableFeed.Type]? = nil,
    defaultJSONDecoderSetup: (@Sendable(JSONDecoder) -> Void)? = nil,
    defaultXMLDecoderSetup: (@Sendable(XMLDecoder) -> Void)? = nil
  ) {
    let resolvedTypes = types ?? Self.defaultTypes
    let jsonSetup = defaultJSONDecoderSetup ?? Self.setupJSONDecoder(_:)
    let xmlSetup = defaultXMLDecoderSetup ?? Self.setupXMLDecoder(_:)

    let xmlDecoder = XMLDecoder()
    xmlSetup(xmlDecoder)
    let jsonDecoder = JSONDecoder()
    jsonSetup(jsonDecoder)

    let decodings: [DecoderSource: [String: AnyDecoding]] = resolvedTypes.map { type -> (DecoderSource, AnyDecoding) in
      let source = type.source
      let setup = type.source as? CustomDecoderSetup
      let decoder: TypeDecoder
      switch (source.source, setup?.setup(decoder:)) {
      case let (.xml, .some(setup)):
        let xml = XMLDecoder()
        setup(xml)
        decoder = xml

      case let (.json, .some(setup)):
        let json = JSONDecoder()
        setup(json)
        decoder = json

      case (.xml, .none):
        decoder = xmlDecoder

      case (.json, .none):
        decoder = jsonDecoder
      }
      return (source.source, type.anyDecoding(using: decoder))
    }
    .reduce(into: [DecoderSource: [(String, AnyDecoding)]]()) { dict, pair in
      let (source, decoding) = pair
      dict[source, default: []].append((type(of: decoding).label, decoding))
    }
    .mapValues { Dictionary(uniqueKeysWithValues: $0) }

    self.types = resolvedTypes
    self.defaultJSONDecoderSetup = jsonSetup
    self.defaultXMLDecoderSetup = xmlSetup
    defaultXMLDecoder = xmlDecoder
    defaultJSONDecoder = jsonDecoder
    self.decodings = decodings
  }

  /// Creates an instance of ``RSSDecoder``
  public convenience init() {
    self.init(types: nil, defaultJSONDecoderSetup: nil, defaultXMLDecoderSetup: nil)
  }

  @Sendable
  internal static func setupJSONDecoder(_ decoder: JSONDecoder) {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .custom(DateFormatterDecoder.RSS.decoder.decode(from:))
  }

  @Sendable
  internal static func setupXMLDecoder(_ decoder: XMLDecoder) {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .custom(DateFormatterDecoder.RSS.decoder.decode(from:))
    decoder.trimValueWhitespaces = false
  }

  /// Returns a ``Feedable`` object of the type you specify, decoded from a JSON object.
  /// - Parameter data: The JSON or XML object to decode.
  /// - Returns: A ``Feedable`` object
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

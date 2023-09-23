//
//  File.swift
//  
//
//  Created by Leo Dion on 9/23/23.
//

import Foundation

extension PodcastPerson {
  private enum KnownRole : String {
    case guest
    case host
    case editor
    case writer
    case designer
    case composer
    case producer
    
    init?(caseInsensitive: String) {
      self.init(rawValue: caseInsensitive.lowercased())
    }
    
    init?(role: Role) {
      switch role {
        
      case .guest:        self = .guest
      case .host:        self = .host
      case .editor:        self = .editor
      case .writer:        self = .writer
      case .designer:        self = .designer
      case .composer:        self = .composer
      case .producer:        self = .producer
      case .unknown:        return nil
      }
    }
  }
  
  public enum Role: Codable, Equatable, RawRepresentable {
    public var rawValue: String {
      if let knownRole = KnownRole(role: self) {
        return knownRole.rawValue
      } else if case let .unknown(string) = self {
        return string
      } else {
        fatalError()
      }
    }
    
    public init(caseInsensitive: String) {
      if let knownRole = KnownRole(caseInsensitive: caseInsensitive) {
        self = .init(knownRole: knownRole)
      } else {
        self = .unknown(caseInsensitive)
      }
    }
    
    private init(knownRole : KnownRole) {
      self.init(rawValue: knownRole.rawValue)!
    }
    
    public init?(rawValue: String) {
      if let knownRole = KnownRole(rawValue: rawValue) {
        self = .init(knownRole: knownRole)
      } else {
        self = .unknown(rawValue)
      }
    }
    
    
    case guest
    case host
    case editor
    case writer
    case designer
    case composer
    case producer
    case unknown(String)
  }
}

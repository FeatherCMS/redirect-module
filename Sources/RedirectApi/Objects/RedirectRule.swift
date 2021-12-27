//
//  Redirect.Rule.swift
//  
//
//  Created by Steve Tibbett on 2021-12-19
//

public extension Redirect {
    
    enum Rule: FeatherApiModel {
        public typealias Module = Redirect
        
        public enum StatusCode: Int, CaseIterable {
            case temporary = 301
            case normal = 303
            case permanent = 307
        }
        
        public static let defaultStatusCode: StatusCode = .temporary
    }
}

public extension Redirect.Rule {
    
    // MARK: -
    
    struct List: Codable {
        public var id: UUID
        public var source: String
        public var destination: String
        public var statusCode: Int
        public var notes: String?
        
        public init(id: UUID,
                    source: String,
                    destination: String,
                    statusCode: Int,
                    notes: String? = nil)
        {
            self.id = id
            self.source = source
            self.destination = destination
            self.statusCode = statusCode
            self.notes = notes
        }
    }
    
    // MARK: -
    
    struct Detail: Codable {
        public var id: UUID
        public var source: String
        public var destination: String
        public var statusCode: Int
        public var notes: String?
        
        public init(id: UUID,
                    source: String,
                    destination: String,
                    statusCode: Int,
                    notes: String? = nil) {
            self.id = id
            self.source = source
            self.destination = destination
            self.statusCode = statusCode
            self.notes = notes
        }
    }
    
    // MARK: -
    
    struct Create: Codable {
        public var source: String
        public var destination: String
        public var statusCode: Int
        public var notes: String?
        
        public init(source: String,
                    destination: String,
                    statusCode: Int,
                    notes: String? = nil) {
            self.source = source
            self.destination = destination
            self.statusCode = statusCode
            self.notes = notes
        }
    }
    
    // MARK: -
    
    struct Update: Codable {
        public var source: String
        public var destination: String
        public var statusCode: Int
        public var notes: String?
        
        public init(source: String,
                    destination: String,
                    statusCode: Int,
                    notes: String? = nil) {
            self.source = source
            self.destination = destination
            self.statusCode = statusCode
            self.notes = notes
        }
    }
    
    // MARK: -
    
    struct Patch: Codable {
        public var source: String
        public var destination: String
        public var statusCode: Int
        public var notes: String?
        
        public init(source: String,
                    destination: String,
                    statusCode: Int,
                    notes: String? = nil) {
            self.source = source
            self.destination = destination
            self.statusCode = statusCode
            self.notes = notes
        }
    }
}

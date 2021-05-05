//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 04. 27..
//

import Foundation

public struct RuleGetObject: Codable {

    public var id: UUID
    public var source: String
    public var destination: String
    public var statusCode: Int

    public init(id: UUID, source: String, destination: String, statusCode: Int) {
        self.id = id
        self.source = source
        self.destination = destination
        self.statusCode = statusCode
    }
}

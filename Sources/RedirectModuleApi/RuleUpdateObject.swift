//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 04. 27..
//

import Foundation

public struct RuleUpdateObject: Codable {

    public var source: String
    public var destination: String
    public var statusCode: Int

    public init(source: String, destination: String, statusCode: Int) {
        self.source = source
        self.destination = destination
        self.statusCode = statusCode
    }
}

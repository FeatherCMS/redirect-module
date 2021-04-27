//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 04. 27..
//

import Foundation

public struct RulePatchObject: Codable {

    public var source: String?
    public var destination: String?
    public var statusCode: Int?

    public init(source: String? = nil, destination: String? = nil, statusCode: Int? = nil) {
        self.source = source
        self.destination = destination
        self.statusCode = statusCode
    }
}

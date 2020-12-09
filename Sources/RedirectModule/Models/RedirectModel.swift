//
//  RedirectModel.swift
//  RedirectModule
//
//  Created by Tibor Bödecs on 2020. 05. 30..
//

import FeatherCore

final class RedirectModel: ViperModel {
    typealias Module = RedirectModule

    static let name = "redirects"

    struct FieldKeys {
        static var source: FieldKey { "source" }
        static var destination: FieldKey { "destination" }
        static var statusCode: FieldKey { "status_code" }
    }

    // MARK: - fields

    @ID() var id: UUID?
    @Field(key: FieldKeys.source) var source: String
    @Field(key: FieldKeys.destination) var destination: String
    @Field(key: FieldKeys.statusCode) var statusCode: Int
    
    init() { }
    
    init(id: IDValue? = nil,
         source: String,
         destination: String,
         statusCode: Int = RedirectModel.defaultCode)
    {
        self.id = id
        self.source = source
        self.destination = destination
        self.statusCode = statusCode
    }
}


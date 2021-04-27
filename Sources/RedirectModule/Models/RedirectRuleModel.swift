//
//  RedirectRuleModel.swift
//  RedirectModule
//
//  Created by Tibor Bödecs on 2020. 05. 30..
//

import Fluent
import FeatherCore

final class RedirectRuleModel: FeatherModel {
    typealias Module = RedirectModule

    static let modelKey: String = "rules"
    static let name: FeatherModelName = "Rule"

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
         statusCode: Int = RedirectRuleModel.defaultCode)
    {
        self.id = id
        self.source = source
        self.destination = destination
        self.statusCode = statusCode
    }
    
    // MARK: - query

    static func allowedOrders() -> [FieldKey] {
        [
            FieldKeys.source,
            FieldKeys.destination,
            FieldKeys.statusCode,
        ]
    }

    static func search(_ term: String) -> [ModelValueFilter<RedirectRuleModel>] {
        [
            \.$source ~~ term,
            \.$destination ~~ term,
        ]
    }
}


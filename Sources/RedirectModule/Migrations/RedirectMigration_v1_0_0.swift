//
//  RedirectMigration_v1_0_0.swift
//  RedirectModule
//
//  Created by Tibor Bödecs on 2020. 05. 30..
//

import Fluent

struct RedirectMigration_v1_0_0: Migration {
        
    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.schema(RedirectRuleModel.schema)
            .id()
            .field(RedirectRuleModel.FieldKeys.source, .string, .required)
            .field(RedirectRuleModel.FieldKeys.destination, .string, .required)
            .field(RedirectRuleModel.FieldKeys.statusCode, .int, .required)
            .unique(on: RedirectRuleModel.FieldKeys.source)
            .create()
    }

    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.schema(RedirectRuleModel.schema).delete()
    }
}


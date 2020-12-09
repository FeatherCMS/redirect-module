//
//  RedirectAdminController.swift
//  RedirectModule
//
//  Created by Tibor Bodecs on 2020. 03. 26..
//

import Fluent
import FeatherCore

struct RedirectAdminController: ViperAdminViewController {

    typealias Module = RedirectModule
    typealias Model = RedirectModel
    typealias CreateForm = RedirectEditForm
    typealias UpdateForm = RedirectEditForm
    
    var listAllowedOrders: [FieldKey] = [
        Model.FieldKeys.source,
        Model.FieldKeys.destination,
        Model.FieldKeys.statusCode,
    ]

    func listQuery(search: String, queryBuilder: QueryBuilder<RedirectModel>, req: Request) {
        queryBuilder.filter(\.$source ~~ search)
        queryBuilder.filter(\.$destination ~~ search)
    }
}

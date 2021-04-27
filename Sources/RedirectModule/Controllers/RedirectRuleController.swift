//
//  RedirectAdminController.swift
//  RedirectModule
//
//  Created by Tibor Bodecs on 2020. 03. 26..
//

import Fluent
import FeatherCore

struct RedirectRuleController: FeatherController {

    typealias Module = RedirectModule
    typealias Model = RedirectRuleModel

    typealias CreateForm = RedirectRuleEditForm
    typealias UpdateForm = RedirectRuleEditForm
    
    typealias GetApi = RedirectRuleApi
    typealias ListApi = RedirectRuleApi
    typealias CreateApi = RedirectRuleApi
    typealias UpdateApi = RedirectRuleApi
    typealias PatchApi = RedirectRuleApi
    typealias DeleteApi = RedirectRuleApi

    func listTable(_ models: [Model]) -> Table {
        Table(columns: ["source", "destination"], rows: models.map { model in
            TableRow(id: model.identifier, cells: [TableCell(model.source), TableCell(model.destination)])
        })
    }
    
    func listContext(req: Request, table: Table, pages: Pagination) -> ListContext {
        .init(info: Model.info(req), table: table, pages: pages)
    }
    
    func detailFields(req: Request, model: Model) -> [DetailContext.Field] {
        [
            .init(label: "Id", value: model.identifier),
            .init(label: "Source", value: model.source),
            .init(label: "Destination", value: model.destination),
            .init(label: "Status code", value: String(model.statusCode)),
        ]
    }

    func deleteContext(req: Request, model: Model) -> String {
        model.source
    }

}

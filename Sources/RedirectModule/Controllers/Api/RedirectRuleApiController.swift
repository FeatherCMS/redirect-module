//
//  RedirectRuleApi.swift
//  
//
//  Created by Steve Tibbett on 2021-12-19
//

import Vapor
import Fluent
import Feather
import RedirectObjects

extension Redirect.Rule.List: Content {}
extension Redirect.Rule.Detail: Content {}

struct RedirectRuleApiController: ApiController {
    typealias ApiModel = Redirect.Rule
    typealias DatabaseModel = RedirectRuleModel
    
    func listOutput(_ req: Request, _ models: [DatabaseModel]) async throws -> [Redirect.Rule.List] {
        models.map { model in
            .init(id: model.uuid,
                  source: model.source,
                  destination: model.destination,
                  statusCode: model.statusCode,
                  notes: model.notes)
        }
    }
    
    func detailOutput(_ req: Request, _ model: DatabaseModel) async throws -> Redirect.Rule.List {
        .init(id: model.id!,
              source: model.source,
              destination: model.destination,
              statusCode: model.statusCode,
              notes: model.notes)
    }
    
    func createInput(_ req: Request, _ model: DatabaseModel, _ input: Redirect.Rule.Create) async throws {
        model.source = input.source
        model.destination = input.destination
        model.statusCode = input.statusCode
        model.notes = input.notes
    }
    
    func updateInput(_ req: Request, _ model: DatabaseModel, _ input: Redirect.Rule.Update) async throws {
        model.source = input.source
        model.destination = input.destination
        model.statusCode = input.statusCode
        model.notes = input.notes
    }
    
    func patchInput(_ req: Request, _ model: DatabaseModel, _ input: Redirect.Rule.Patch) async throws {
        model.source = input.source
        model.destination = input.destination
        model.statusCode = input.statusCode
        model.notes = input.notes
    }
    
    func validators(optional: Bool) -> [AsyncValidator] {
        [
            KeyedContentValidator<String>.required("source", optional: optional),
            KeyedContentValidator<String>.required("destination", optional: optional),
            KeyedContentValidator<Int>.contains("statusCode", Redirect.Rule.StatusCode.allCases.map(\.rawValue), optional: optional),
//            KeyedContentValidator<String>("source", "Source must be unique", optional: optional) { req, value in
//                try await DatabaseModel.isUnique(req, \.$source == value, Redirect.Rule.getIdParameter(req))
//            }
        ]
    }
}

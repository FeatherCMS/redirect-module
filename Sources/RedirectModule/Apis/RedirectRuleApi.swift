//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 04. 27..
//

import FeatherCore
import RedirectApi

extension RuleListObject: Content {}
extension RuleGetObject: Content {}
extension RuleCreateObject: Content {}
extension RuleUpdateObject: Content {}
extension RulePatchObject: Content {}

struct RedirectRuleApi: FeatherApiRepresentable {
    typealias Model = RedirectRuleModel
    
    typealias ListObject = RuleListObject
    typealias GetObject = RuleGetObject
    typealias CreateObject = RuleCreateObject
    typealias UpdateObject = RuleUpdateObject
    typealias PatchObject = RulePatchObject
    
    func mapList(model: Model) -> ListObject {
        .init(id: model.id!,
              source: model.source,
              destination: model.destination,
              statusCode: model.statusCode)
    }

    func mapGet(model: Model) -> GetObject {
        .init(id: model.id!,
              source: model.source,
              destination: model.destination,
              statusCode: model.statusCode)
    }
    
    func mapCreate(_ req: Request, model: Model, input: CreateObject) -> EventLoopFuture<Void> {
        model.source = input.source
        model.destination = input.destination
        model.statusCode = input.statusCode
        return req.eventLoop.future()
    }
        
    func mapUpdate(_ req: Request, model: Model, input: UpdateObject) -> EventLoopFuture<Void> {
        model.source = input.source
        model.destination = input.destination
        model.statusCode = input.statusCode
        return req.eventLoop.future()
    }

    func mapPatch(_ req: Request, model: Model, input: PatchObject) -> EventLoopFuture<Void> {
        model.source = input.source ?? model.source
        model.destination = input.destination ?? model.destination
        model.statusCode = input.statusCode ?? model.statusCode
        return req.eventLoop.future()
    }
    
    func validators(optional: Bool) -> [AsyncValidator] {
        [
            KeyedContentValidator<String>.required("source", optional: optional),
            KeyedContentValidator<String>.required("destination", optional: optional),
            KeyedContentValidator<Int>.contains("statusCode", RedirectRuleModel.validCodes, optional: optional),
            KeyedContentValidator<String>("source", "Source must be unique", optional: optional, nil) { value, req in
                Model.isUniqueBy(\.$source == value, req: req)
            }
        ]
    }
}


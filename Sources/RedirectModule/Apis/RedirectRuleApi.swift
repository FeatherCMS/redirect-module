//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 04. 27..
//

import FeatherCore
import RedirectModuleApi

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
        .init(id: model.id!, source: model.source, destination: model.destination, statusCode: model.statusCode)
    }

    func mapGet(model: Model) -> GetObject {
        .init(id: model.id!, source: model.source, destination: model.destination, statusCode: model.statusCode)
    }
    
    func mapCreate(_ req: Request, model: Model, input: CreateObject) -> EventLoopFuture<Void> {
        return req.eventLoop.future()
    }
        
    func mapUpdate(_ req: Request, model: Model, input: UpdateObject) -> EventLoopFuture<Void> {
        return req.eventLoop.future()
    }

    func mapPatch(_ req: Request, model: Model, input: PatchObject) -> EventLoopFuture<Void> {
        return req.eventLoop.future()
    }
    
    func validateCreate(_ req: Request) -> EventLoopFuture<Bool> {
        req.eventLoop.future(true)
    }
    
    func validateUpdate(_ req: Request) -> EventLoopFuture<Bool> {
        req.eventLoop.future(true)
    }
    
    func validatePatch(_ req: Request) -> EventLoopFuture<Bool> {
        req.eventLoop.future(true)
    }

    
}


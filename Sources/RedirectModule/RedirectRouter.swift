//
//  RedirectRouter.swift
//  RedirectModule
//
//  Created by Tibor Bodecs on 2020. 01. 24..
//

import FeatherCore

struct RedirectRouter: RouteCollection {
    
    var ruleController = RedirectRuleController()
    
    func boot(routes: RoutesBuilder) throws {
        
    }
    
    func adminRoutesHook(args: HookArguments) {
        let adminRoutes = args.routes
        
        adminRoutes.get("redirect", use: SystemAdminMenuController(key: "redirect").moduleView)

        adminRoutes.register(ruleController)
    }
    
    func apiRoutesHook(args: HookArguments) {
//        let publicApiRoutes = args.routes
    }
    
    func apiAdminRoutesHook(args: HookArguments) {
        let apiRoutes = args.routes

        apiRoutes.registerApi(ruleController)
    }
}

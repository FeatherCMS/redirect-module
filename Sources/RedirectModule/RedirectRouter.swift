//
//  RedirectRouter.swift
//  RedirectModule
//
//  Created by Tibor Bodecs on 2020. 01. 24..
//

import FeatherCore

struct RedirectRouter: FeatherRouter {
    
    var ruleController = RedirectRuleController()
    
    func adminRoutesHook(args: HookArguments) {
        let adminRoutes = args.routes
        
        adminRoutes.get("redirect", use: SystemAdminMenuController(key: "redirect").moduleView)

        adminRoutes.register(ruleController)
    }
    
    func apiAdminRoutesHook(args: HookArguments) {
        let apiRoutes = args.routes

        apiRoutes.registerApi(ruleController)
    }
}

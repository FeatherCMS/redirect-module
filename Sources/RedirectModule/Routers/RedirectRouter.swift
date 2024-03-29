//
//  RedirectRouter.swift
//  
//
//  Created by Steve Tibbett on 2021-12-19
//

struct RedirectRouter: FeatherRouter {
 
    let ruleAdminController = RedirectRuleAdminController()
    let ruleApiController = RedirectRuleApiController()

    func adminRoutesHook(args: HookArguments) {
        ruleAdminController.setupRoutes(args.routes)
        
        args.routes.get("redirect") { req -> Response in
            let template = AdminModulePageTemplate(.init(title: "Redirect", message: "This module lets you configure redirect rules.", links: [
                .init(label: "Rules", path: "/admin/redirect/rules/"),
            ]))
            return req.templates.renderHtml(template)
        }
    }
    
    func apiRoutesHook(args: HookArguments) {
        ruleApiController.setupRoutes(args.routes)
    }
}

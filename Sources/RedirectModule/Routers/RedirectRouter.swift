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
        ruleAdminController.setUpRoutes(args.routes)
        
        args.routes.get(Redirect.pathKey.pathComponent) { req -> Response in
            let template = AdminModulePageTemplate(.init(title: "Redirect",
                                                         tag: RedirectAdminWidgetTemplate().render(req)))
            return req.templates.renderHtml(template)
        }
    }
    
    func apiRoutesHook(args: HookArguments) {
        ruleApiController.setUpRoutes(args.routes)
    }
}

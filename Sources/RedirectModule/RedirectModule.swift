//
//  RedirectModule.swift
//  RedirectModule
//
//  Created by Tibor Bodecs on 2020. 01. 25..
//

import FeatherCore

final class RedirectModule: FeatherModule {

    static let moduleKey = "redirect"
       
    func boot(_ app: Application) throws {
        app.migrations.add(RedirectMigration_v1_0_0())
        /// routes
        let router = RedirectRouter()
        try router.boot(routes: app.routes)
        app.hooks.register(.adminRoutes, use: router.adminRoutesHook)
        app.hooks.register(.apiRoutes, use: router.apiRoutesHook)
        app.hooks.register(.apiAdminRoutes, use: router.apiAdminRoutesHook)
        /// response
        app.hooks.register(.response, use: responseHook)
        /// template
        app.hooks.register(.adminMenu, use: adminMenuHook)
        /// permission
        app.hooks.register(.installPermissions, use: installPermissionsHook)
    }

    // MARK: - hooks

    func adminMenuHook(args: HookArguments) -> HookObjects.AdminMenu {
        .init(key: "redirect",
              item: .init(icon: "redirect", link: Self.adminLink, permission: Self.permission(for: .custom("admin")).identifier),
              children: [
                .init(link: RedirectRuleModel.adminLink, permission: RedirectRuleModel.permission(for: .list).identifier),
              ])
    }

    func responseHook(args: HookArguments) -> EventLoopFuture<Response?> {
        let req = args.req
        return RedirectRuleModel
            .query(on: req.db)
            .filter(\.$source == req.url.path)
            .first()
            .map {
                guard let model = $0 else {
                    return nil
                }
                return req.redirect(to: model.destination, type: model.type)
            }
    }
    
    func installPermissionsHook(args: HookArguments) -> [PermissionCreateObject] {
        var permissions: [PermissionCreateObject] = [
            RedirectModule.hookInstallPermission(for: .custom("admin"))
        ]
        permissions += RedirectRuleModel.hookInstallPermissions()
        return permissions
    }
}

//
//  RedirectModule.swift
//  RedirectModule
//
//  Created by Tibor Bodecs on 2020. 01. 25..
//

import FeatherCore

final class RedirectModule: ViperModule {

    static let name = "redirect"
    var priority: Int { 2000 }

    var router: ViperRouter? = RedirectRouter()

    var migrations: [Migration] {
        [
            RedirectMigration_v1_0_0(),
        ]
    }

    static var bundleUrl: URL? {
        Bundle.module.resourceURL?.appendingPathComponent("Bundle")
    }
   
    func boot(_ app: Application) throws {
        /// routes
        app.hooks.register("admin-routes", use: (router as! RedirectRouter).adminRoutesHook)
        app.hooks.register("frontend-route", use: frontendRouteHook)
        /// leaf
        app.hooks.register("leaf-admin-menu", use: leafAdminMenuHook)
        /// permission
        app.hooks.register("user-permission-install", use: userPermissionInstallHook)
    }

    // MARK: - hooks

    func leafAdminMenuHook(args: HookArguments) -> LeafDataRepresentable {
        [
            "name": "Redirect",
            "icon": "arrow-right",
            "permission": "redirect.module.access",
            "items": LeafData.array([
                [
                    "label": "Redirects",
                    "url": "/admin/redirect/redirects/",
                    "permission": "redirect.redirects.list",
                ],
            ])
        ]
    }

    func frontendRouteHook(args: HookArguments) -> EventLoopFuture<Response?> {
        let req = args["req"] as! Request
        return RedirectModel
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
}

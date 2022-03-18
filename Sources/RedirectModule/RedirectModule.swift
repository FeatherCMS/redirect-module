//
//  RedirectModule.swift
//
//
//  Created by Steve Tibbett on 2021-12-19
//

import Vapor
import Fluent
import Feather
import FeatherObjects
import RedirectObjects

public extension HookName {
//    static let permission: HookName = "redirect"
}

/**
 Allows configuring of redirects via Redirect.Rule instances.  Redirects turn a
 GET request to a given source path into a redirect to a destination URL,
 either relative or absolute.  Redirect type is specified by statusCode (301,
 303, or 308).
 */
struct RedirectModule: FeatherModule {

    let router = RedirectRouter()
    
    func boot(_ app: Application) throws {
        app.migrations.add(RedirectMigrations.v1())

        app.hooks.register(.adminRoutes, use: router.adminRoutesHook)
        app.hooks.register(.apiRoutes, use: router.apiRoutesHook)
        app.hooks.register(.adminWidgets, use: adminWidgetsHook, priority: 200)
        app.hooks.registerAsync(.response, use: responseHook)
        app.hooks.register(.installPermissions, use: installUserPermissionsHook)
    }

    func installUserPermissionsHook(args: HookArguments) -> [FeatherPermission.Create] {
        var permissions = Redirect.availablePermissions()
        permissions += Redirect.Rule.availablePermissions()
        return permissions.map { .init($0) }
    }
    
    func adminWidgetsHook(args: HookArguments) -> [TemplateRepresentable] {
        if args.req.checkPermission(Redirect.permission(for: .detail)) {
            return [
                RedirectAdminWidgetTemplate()
            ]
        }
        return []
    }
    
    /**
     Apply redirect rules to incoming requests.
     */
    func responseHook(args: HookArguments) async throws -> Response? {
        let req = args.req
        guard let rule = try await RedirectRuleModel
                .query(on: req.db)
                .filter(\.$source == req.url.path)
                .first() else {
                    return nil
                }

        let type: RedirectType
        switch UInt(rule.statusCode) {
        case HTTPResponseStatus.movedPermanently.code:
            type = .permanent
        case HTTPResponseStatus.temporaryRedirect.code:
            type = .temporary
        default:
            type = .normal
        }
        return req.redirect(to: rule.destination, type: type)
    }

}

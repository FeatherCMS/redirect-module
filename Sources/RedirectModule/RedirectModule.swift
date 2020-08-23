//
//  RedirectModule.swift
//  FeatherCMS
//
//  Created by Tibor Bodecs on 2020. 01. 25..
//

import Vapor
import Fluent
import ViperKit

final class RedirectModule: ViperModule {

    static let name = "redirect"

    var router: ViperRouter? = RedirectRouter()

    var migrations: [Migration] {
        [
            RedirectMigration_v1_0_0(),
        ]
    }
    
    // MARK: - hook functions
    
    func invoke(name: String, req: Request, params: [String : Any] = [:]) -> EventLoopFuture<Any?>? {
        switch name {
        case "frontend-page":
            return self.frontendPageHook(req: req)
        default:
            return nil
        }
    }

    private func frontendPageHook(req: Request) -> EventLoopFuture<Any?>? {
        RedirectModel
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

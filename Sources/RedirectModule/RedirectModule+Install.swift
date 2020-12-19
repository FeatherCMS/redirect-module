//
//  RedirectModule+Install.swift
//  RedirectModule
//
//  Created by Tibor Bodecs on 2020. 12. 19..
//

import FeatherCore

extension RedirectModule {

    func userPermissionInstallHook(args: HookArguments) -> [[String: Any]] {
        [
            ["key": "redirect", "name": "Redirect module"],
        ] +
        RedirectModel.permissions
    }
}

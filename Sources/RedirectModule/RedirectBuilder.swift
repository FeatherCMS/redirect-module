//
//  RedirectBuilder.swift
//  RedirectModule
//
//  Created by Tibor Bodecs on 2020. 08. 23..
//

import FeatherCore

@_cdecl("createRedirectModule")
public func createRedirectModule() -> UnsafeMutableRawPointer {
    return Unmanaged.passRetained(RedirectBuilder()).toOpaque()
}

public final class RedirectBuilder: FeatherModuleBuilder {

    public override func build() -> FeatherModule {
        RedirectModule()
    }
}

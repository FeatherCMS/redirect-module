//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 27..
//

import Feather

@_cdecl("createRedirectModule")
public func createRedirectModule() -> UnsafeMutableRawPointer {
    return Unmanaged.passRetained(RedirectBuilder()).toOpaque()
}

public final class RedirectBuilder: FeatherModuleBuilder {

    public override func build() -> FeatherModule {
        RedirectModule()
    }
}

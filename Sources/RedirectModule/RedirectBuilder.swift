//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2020. 08. 23..
//

import Foundation
import ViperKit

@_cdecl("createModule")
public func createModule() -> UnsafeMutableRawPointer {
    return Unmanaged.passRetained(RedirectBuilder()).toOpaque()
}

public final class RedirectBuilder: ViperBuilder {

    public override func build() -> ViperModule {
        RedirectModule()
    }
}

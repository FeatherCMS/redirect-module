//
//  RedirectModel+StatusCodes.swift
//  RedirectModule
//
//  Created by Tibor Bodecs on 2020. 12. 09..
//

import FeatherCore

extension RedirectModel {

    static let defaultCode = 301
    static let validCodes = [301, 303, 307]

    var type: RedirectType {
        switch statusCode {
        case 301:
            return .permanent
        case 307:
            return .temporary
        default:
            return .normal
        }
    }
}

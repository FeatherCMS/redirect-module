//
//  RedirectModel+View.swift
//  RedirectModule
//
//  Created by Tibor Bodecs on 2020. 06. 02..
//

import FeatherCore

extension RedirectModel: TemplateDataRepresentable {

    var templateData: TemplateData {
        .dictionary([
            "id": id,
            "source": source,
            "destination": destination,
            "statusCode": statusCode,
        ])
    }
}

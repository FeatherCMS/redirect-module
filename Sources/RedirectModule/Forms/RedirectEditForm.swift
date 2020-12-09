//
//  RedirectEditForm.swift
//  RedirectModule
//
//  Created by Tibor Bodecs on 2020. 02. 17..
//

import FeatherCore

final class RedirectEditForm: ModelForm {
    typealias Model = RedirectModel

    var modelId: UUID?
    var source = FormField<String>(key: "source").required().length(max: 250)
    var destination = FormField<String>(key: "destination").required().length(max: 250)
    var statusCode = SelectionFormField<Int>(key: "statusCode") // @TODO: validation
    var notification: String?

    var fields: [FormFieldRepresentable] {
        [source, destination, statusCode]
    }

    init() {}

    func initialize(req: Request) -> EventLoopFuture<Void> {
        statusCode.options = FormFieldOption.numbers(Model.validCodes)
        statusCode.value = RedirectModel.defaultCode
        return req.eventLoop.future()
    }

    func read(from input: Model)  {
        source.value = input.source
        destination.value = input.destination
        statusCode.value = input.statusCode
    }

    func write(to output: Model) {
        output.source = source.value!
        output.destination = destination.value!
        output.statusCode = statusCode.value!
    }
}

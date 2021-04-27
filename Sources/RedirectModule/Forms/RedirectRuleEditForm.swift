//
//  RedirectEditForm.swift
//  RedirectModule
//
//  Created by Tibor Bodecs on 2020. 02. 17..
//

import FeatherCore

struct RedirectRuleEditForm: FeatherForm {
    
    var context: FeatherFormContext<RedirectRuleModel>
    
    init() {
        context = .init()
        context.form.fields = createFormFields()
    }

    private func createFormFields() -> [FormComponent] {
        [
            TextField(key: "source")
                .config { $0.output.required = true }
                .validators { [
                    FormFieldValidator($1, "Source is required") { !$0.input.isEmpty },
                ] }
                .read { $1.output.value = context.model?.source }
                .write { context.model?.source = $1.input },
            
            TextField(key: "destination")
                .config { $0.output.required = true }
                .validators { [
                    FormFieldValidator($1, "Destination is required") { !$0.input.isEmpty },
                ] }
                .read { $1.output.value = context.model?.destination }
                .write { context.model?.destination = $1.input },

            SelectionField(key: "statusCode", value: MetadataStatus.draft.rawValue)
                .config {
                    $0.output.required = true
                    $0.output.label = "Status code"
                    $0.output.options = RedirectRuleModel.validCodes.map { .init(key: String($0), label: String($0)) }
                }
//                .validators { [
//                    FormFieldValidator($1, "Invalid status") { field in
//                        Metadata.Status(rawValue: field.input) != nil
//                    }
//                ] }
                .read { $1.output.value = String(context.model?.statusCode ?? RedirectRuleModel.defaultCode) }
                .write { context.model?.statusCode = Int($1.input)! },
        ]
    }
}

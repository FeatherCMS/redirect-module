//
//  RedirectRuleEditor.swift
//  
//
//  Created by Steve Tibbett on 2021-12-19
//

import Feather
import Vapor
import RedirectObjects

struct RedirectRuleEditor: FeatherModelEditor {    
    let model: RedirectRuleModel
    let form: AbstractForm

    init(model: RedirectRuleModel, form: AbstractForm) {
        self.model = model
        self.form = form
    }

    @FormFieldBuilder
    func createFields(_ req: Request) -> [FormField] {
        InputField("source")
            .config {
                $0.output.context.label.required = true
                $0.output.context.label.title = "Source path"
            }
            .validators {
                FormFieldValidator.required($1)
            }
            .read { $1.output.context.value = model.source }
            .write { model.source = $1.input.safePath() }
        
        InputField("destination")
            .config {
                $0.output.context.label.required = true
                $0.output.context.label.title = "Destination URL or path"
            }
            .read { $1.output.context.value = model.destination }
            .write { model.destination = $1.input }
            .validators {
                FormFieldValidator.required($1)
            }

        SelectField("statusCode")
            .config {
                $0.output.context.label.required = true
                $0.output.context.label.title = "Status code"
                $0.output.context.options = Redirect.Rule.StatusCode.allCases.map { OptionContext(key: String($0.rawValue), label: String($0.rawValue)) }
                $0.output.context.value = String(Redirect.Rule.defaultStatusCode.rawValue)
            }
            .validators {
                FormFieldValidator($1, "Invalid status") { _, field in
                    guard let value = Int(field.input) else {
                        return false
                    }
                    return Redirect.Rule.StatusCode(rawValue: value) != nil
                }
            }
            .read { $1.output.context.value = String(model.statusCode) }
            .write { model.statusCode = Int($1.input) ?? Redirect.Rule.defaultStatusCode.rawValue }
        
        TextareaField("notes")
            .read { $1.output.context.value = model.notes }
            .write { model.notes = $1.input }
    }
}


//
//  RedirectModuleTests.swift
//  RedirectModule
//
//  Created by Tibor Bodecs on 2020. 08. 23..
//

import FeatherTest
import RedirectApi
@testable import RedirectModule

extension RuleGetObject: UUIDContent {}

final class RedirectRuleApiTests: FeatherApiTestCase {
    
    override class func testModules() -> [FeatherModule] {
        [RedirectModule()]
    }

    override func modelName() -> String {
        "Rule"
    }
    
    override func endpoint() -> String {
        "redirect/rules"
    }
    
    func testListRules() throws {
        try list(RuleListObject.self)
    }
    
    func testCreateRule() throws {
        let uuid = UUID().uuidString
        let input = RuleCreateObject(source: "source" + uuid, destination: "/", statusCode: 301)
        try create(input, RuleGetObject.self) { item in
            XCTAssertEqual(item.source, "source" + uuid)
        }
    }
    
    func testCreateInvalidRule() throws {
        let input = RuleCreateObject(source: "", destination: "", statusCode: 0)
        try createInvalid(input) { error in
            XCTAssertEqual(error.details.count, 3)
        }
    }
    
    func testUpdateRule() throws {
        let uuid = UUID().uuidString
        let input = RuleCreateObject(source: "source" + uuid, destination: "/", statusCode: 301)
        let uuid2 = UUID().uuidString
        let up = RuleUpdateObject(source: "source2" + uuid2, destination: "/", statusCode: 301)
        try update(input, up, RuleGetObject.self) { item in
            XCTAssertEqual(item.source, "source2" + uuid2)
        }
    }
    
    func testPatchRule() throws {
        let uuid = UUID().uuidString
        let input = RuleCreateObject(source: "source" + uuid, destination: "/", statusCode: 301)
        let uuid2 = UUID().uuidString
        let up = RulePatchObject(source: "source2" + uuid2)

        try patch(input, up, RuleGetObject.self) { item in
            XCTAssertEqual(item.source, "source2" + uuid2)
        }
    }
    
    func testUniqueKeyFailure() throws {
        let uuid = UUID().uuidString
        let input = RuleCreateObject(source: "source" + uuid, destination: "/", statusCode: 301)
        try create(input, RuleGetObject.self) { item in
            /// ok
        }

        try createInvalid(input) { error in
            XCTAssertEqual(error.details.count, 1)
            XCTAssertEqual(error.details[0].key, "source")
            XCTAssertEqual(error.details[0].message, "Source must be unique")
        }
    }

    func testDeleteRule() throws {
        let uuid = UUID().uuidString
        let input = RuleCreateObject(source: "source" + uuid, destination: "/", statusCode: 301)
        try delete(input, RuleGetObject.self)
    }
    
    func testMissingDeleteRule() throws {
        try deleteMissing()
    }
}


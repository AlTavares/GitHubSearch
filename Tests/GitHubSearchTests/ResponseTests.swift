//
//  ResponseTests.swift
//  GitHubSearchTests
//
//  Created by Alexandre Mantovani Tavares on 27/06/20.
//

@testable import GitHubSearch
import Nimble
import Quick
import SnapshotTesting
import XCTest

class ResponseTests: QuickSpec {
    @Locatable var jsonDecoder: JSONDecoder
    override func spec() {
        describe("a github api response") {
            it("succesfully decodes a json input into a model") {
                let json = try File.load(name: "repositories.json")
                let response = try self.jsonDecoder.decode(ResponseGitHubAPI.self, from: json)
                assertSnapshot(matching: response, as: .dump)
            }
        }
    }
}

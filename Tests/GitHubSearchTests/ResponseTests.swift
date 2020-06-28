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
    override func spec() {
        describe("a github api response") {
            it("succesfully decodes a json input into a model") {
                let response = try File.repositories()
                assertSnapshot(matching: response, as: .dump)
            }
            it("should map to the view data objects") {
                let response = try File.repositories()
                let viewDataObjects = [RepositoryViewData](from: response)
                assertSnapshot(matching: viewDataObjects, as: .dump)
            }
        }
    }
}

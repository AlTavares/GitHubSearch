//
//  GitHubServiceTest.swift
//  GitHubSearchTests
//
//  Created by Alexandre Mantovani Tavares on 27/06/20.
//

@testable import GitHubSearch
import Nimble
import Quick
import SnapshotTesting
import XCTest

class GitHubServiceTest: QuickSpec {
    override func spec() {
        describe("a GitHub service") {
            context("when searching") {
                it("should create the search queries correctly") {
                    let parameters: [GitHub.SearchParameters] = [
                        .init(term: .language("someLanguage")),
                        .init(term: .language("stuff"),
                              page: 10,
                              itemsPerPage: 50,
                              sorting: .forks,
                              order: .descending),
                        .init(term: .language("random"),
                              page: 15,
                              itemsPerPage: 15,
                              sorting: .updated,
                              order: .ascending),
                    ]

                    assertSnapshot(matching: parameters, as: .json)
                }
            }
        }
    }
}

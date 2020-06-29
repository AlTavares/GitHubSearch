//
//  RepositoryViewTests.swift
//  GitHubSearchTests
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Combine
@testable import GitHubSearch
import Nimble
import Quick
import SnapshotTesting
import SwiftUI
import XCTest
class RepositoryViewTests: QuickSpec {
    override func spec() {
        describe("a repository search view") {
            let viewModel = FakeRepositorySearchViewModel()
            let view = RepositorySearchView(viewModel: viewModel)
            it("matches the snapshot on empty state") {
                assertSnapshot(matching: view, as: .image)
            }
            it("matches the snapshot on loading state") {
                viewModel.state = .loading
                assertSnapshot(matching: view, as: .image)
            }
            it("matches the snapshot on loaded state") {
                viewModel.searchTerm = "SWIFT"
                assertSnapshot(matching: view, as: .image)
            }
        }
    }
}

class FakeRepositorySearchViewModel: RepositorySearchViewModel {
    override var searchDelay: DispatchQueue.SchedulerTimeType.Stride { .zero }
    override var searchTerm: String {
        willSet {
            _ = search(for: newValue, page: 0)
        }
    }

    override func setupSearch() {}
    override func search(for term: String, page: UInt) -> AnyPublisher<RepositorySearchViewModel.ModelState, Never> {
        let response = try! File.repositories()
        let viewDataObjects = [RepositoryViewData](from: response)
        let state = RepositorySearchViewModel.ModelState.loaded(viewDataObjects)
        self.state = state
        return Just(state).eraseToAnyPublisher()
    }
}

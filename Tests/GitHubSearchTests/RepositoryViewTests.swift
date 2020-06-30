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
    var bag = CancelBag()
    override func spec() {
        describe("a repository search view") {
            let viewModel = FakeRepositorySearchViewModel()
            let view = RepositorySearchView(viewModel: viewModel)
            it("matches the snapshot on empty state") {
                assertSnapshot(matching: view, named: "repo.search.idle")
            }
            it("matches the snapshot on loading state") {
                viewModel.state = .loading
                assertSnapshot(matching: view, named: "repo.search.loading")
            }
            it("matches the snapshot on loaded state") {
                viewModel.searchTerm = "SWIFT"
                assertSnapshot(matching: view, named: "repo.search.loaded")
            }
        }
        describe("a repository cell view") {
            it("matches the snapshot") {
                let view = RepositoryCellView(
                    viewData: RepositoryViewData(id: 1,
                                                 name: "AlpacaRepo",
                                                 itemDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec accumsan mattis lacinia. Quisque rhoncus laoreet est, et mollis erat varius ultrices. Vestibulum sed sollicitudin nunc.",
                                                 owner: .init(userName: "Alpaca",
                                                              avatarURL: "https://avatars1.githubusercontent.com/u/4191215?s=460&u=57e3516be548dea195036405b8b75f8cecca00fe&v=4"),
                                                 stargazersCount: 12,
                                                 forksCount: 24)
                )

                assertSnapshot(matching: view, named: "repo.cell.loaded")
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

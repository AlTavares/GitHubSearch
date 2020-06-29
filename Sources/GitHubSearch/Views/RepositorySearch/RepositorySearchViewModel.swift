//
//  RepositorySearchViewModel.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Combine
import Foundation

class RepositorySearchViewModel: ObservableObject {
    private enum Constants {
        static let firstPage: UInt = 1
        static let itemsPerPage: UInt = 10
    }

    private var bag = CancelBag()
    @Locatable private var service: GitHubService

    typealias ModelState = ValueState<[RepositoryViewData]>
    @Published var state: ModelState = .idle
    @Published var searchTerm: String = ""

    @UserDefault("latestSuccesfulSearch", defaultValue: "")
    private var latestSuccesfulSearch: String

    var searchDelay: DispatchQueue.SchedulerTimeType.Stride { .milliseconds(300) }
    var currentPage: UInt = Constants.firstPage

    init() {
        setupSearch()
    }

    func setupSearch() {
        searchTerm = latestSuccesfulSearch
        let publisher = $searchTerm
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.state = .loading
            })
            .debounce(for: searchDelay, scheduler: DispatchQueue.main)
            .map { [weak self] term -> AnyPublisher<ModelState, Never> in
                guard let self = self, !term.isEmpty else { return Just(.idle).eraseToAnyPublisher() }
                return self.search(for: term, page: Constants.firstPage)
            }
            .switchToLatest()
            .eraseToAnyPublisher()

        assignState(from: publisher)
    }

    private func assignState(from publisher: AnyPublisher<ModelState, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, on: self)
            .store(in: &bag)
    }

    func search(for term: String, page: UInt) -> AnyPublisher<ModelState, Never> {
        let search = GitHubService.SearchParameters(
            term: .language(term.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)),
            page: page,
            itemsPerPage: Constants.itemsPerPage
        )

        return service
            .search(with: search)
            .map([RepositoryViewData].init)
            .map(ValueState.loaded)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.currentPage = page
                self?.latestSuccesfulSearch = term
            })
            .catch { Just(ValueState.error($0)) }
            .eraseToAnyPublisher()
    }

    private var isLoadingMore = false
    func loadMore() {
        guard !isLoadingMore else { return }
        guard let items = state.value else { return }
        logger.debug("loading more")
        isLoadingMore = true
        let publisher = search(for: searchTerm, page: currentPage + 1)
            .compactMap { newState -> ModelState? in
                guard let newItems = newState.value else { return nil }
                return ModelState.loaded(items + newItems)
            }
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoadingMore = false
            })
            .eraseToAnyPublisher()

        assignState(from: publisher)
    }

    func isLastItem(_ item: RepositoryViewData) -> Bool {
        item == state.value?.last
    }
}

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
        static let itemsPerPage: UInt = 10
    }

    private var bag = CancelBag()
    @Locatable private var service: GitHubService

    typealias ModelState = ValueState<[RepositoryViewData]>
    @Published var state: ModelState = .idle

    @Published var searchTerm: String = ""
    private let retrySignal = PassthroughSubject<Void, Never>()

    var searchDelay: DispatchQueue.SchedulerTimeType.Stride { .milliseconds(300) }

    init() {
        setupSearch()
    }

    func setupSearch() {
        $searchTerm
            .dropFirst()
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.state = .loading
            })
            .debounce(for: searchDelay, scheduler: DispatchQueue.main)
            .map { [weak self] term -> AnyPublisher<ModelState, Never> in
                guard let self = self, !term.isEmpty else { return Just(.idle).eraseToAnyPublisher() }
                return self.search(for: term)
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, on: self)
            .store(in: &bag)
    }

    func search(for term: String) -> AnyPublisher<ModelState, Never> {
        service
            .search(with: .init(term: .language(term.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)),
                                page: 0,
                                itemsPerPage: Constants.itemsPerPage))
            .map([RepositoryViewData].init)
            .map(ValueState.loaded)
            .catch { Just(ValueState.error($0)) }
            .eraseToAnyPublisher()
    }
}

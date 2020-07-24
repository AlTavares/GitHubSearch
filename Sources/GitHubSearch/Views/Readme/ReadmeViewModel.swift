//
//  ReadmeViewModel.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 29/06/20.
//

import Combine
import Foundation

class ReadmeViewModel: ObservableObject {
    let repositoryData: RepositoryData
    init(repositoryData: RepositoryData) {
        self.repositoryData = repositoryData
    }

    private var bag = CancelBag()
    @Locatable private var service: GitHubReadMeService

    typealias ModelState = ValueState<String>
    @Published var state: ModelState = .idle

    func load() {
        state = .loading
        service
            .loadReadme(from: repositoryData)
            .map(ValueState.loaded)
            .catch { Just(ValueState.error($0)) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, on: self)
            .store(in: &bag)
    }
}

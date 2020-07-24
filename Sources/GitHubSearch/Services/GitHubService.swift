//
//  GitHubService.swift
//  GitHubSearchApp
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Combine
import Foundation

protocol GitHubSearchService {
    func search(with parameters: GitHub.SearchParameters) -> AnyPublisher<ResponseGitHubAPI, Error>
}

protocol GitHubReadMeService {
    func loadReadme(from repository: RepositoryData) -> AnyPublisher<String, Error>
}

class GitHubService: GitHubSearchService, GitHubReadMeService {
    private enum API {
        static let baseURL = "https://api.github.com"
        static let defaultHeaders: HTTPHeaders = ["Accept": "application/vnd.github.v3+json"]

        enum Endpoints {
            static let searchRepositories = "/search/repositories"
            static func readme(from repository: RepositoryData) -> String {
                "/repos/\(repository.owner)/\(repository.name)/readme"
            }
        }
    }

    @Locatable private var httpClient: HTTPClient

    func search(with parameters: GitHub.SearchParameters) -> AnyPublisher<ResponseGitHubAPI, Error> {
        let request = Request(host: API.baseURL,
                              path: API.Endpoints.searchRepositories,
                              queryItems: parameters.queryItems,
                              headers: API.defaultHeaders)
        return httpClient.perform(request: request)
            .eraseToAnyPublisher()
    }

    func loadReadme(from repository: RepositoryData) -> AnyPublisher<String, Error> {
        let request = Request(host: API.baseURL,
                              path: API.Endpoints.readme(from: repository),
                              headers: ["Accept": "application/vnd.github.VERSION.html"])
        return httpClient.performData(request: request)
            .map { String(data: $0, encoding: .utf8) }
            .replaceNil(with: "")
            .eraseToAnyPublisher()
    }
}

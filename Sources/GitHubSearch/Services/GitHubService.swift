//
//  GitHubService.swift
//  GitHubSearchApp
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Combine
import Foundation

class GitHubService {
    private enum API {
        static let baseURL = "https://api.github.com"
        static let defaultHeaders: HTTPHeaders = ["Accept": "application/vnd.github.v3+json"]

        enum Endpoints {
            static let searchRepositories = "/search/repositories"
        }
    }

    @Locatable private var httpClient: HTTPClient

    // https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc&page=0&per_page=1000

    func search(with parameters: SearchParameters) -> AnyPublisher<ResponseGitHubAPI, Error> {
        let request = Request(host: API.baseURL,
                              path: API.Endpoints.searchRepositories,
                              queryItems: parameters.queryItems)
        return httpClient.perform(request: request)
            .eraseToAnyPublisher()
    }
}

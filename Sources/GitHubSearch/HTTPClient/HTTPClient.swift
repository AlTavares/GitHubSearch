//
//  HTTPClient.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Combine
import Foundation

class HTTPClient {
    enum RequestError: Swift.Error {
        case unableToCreateRequest
    }

    @Locatable private var urlSession: URLSession
    @Locatable private var cache: RequestCache

    func perform<T: Decodable>(request: Request) -> AnyPublisher<T, Error> {
        guard let urlRequest = request.asURLRequest() else {
            return Fail<T, Error>(error: RequestError.unableToCreateRequest)
                .eraseToAnyPublisher()
        }

        logger.debug(urlRequest.curlString)

        if let cached = cache[request], let value = cached as? T {
            return Result.Publisher(value).eraseToAnyPublisher()
        }

        return urlSession.dataTaskPublisher(for: urlRequest)
            .tryMap { data, _ in
                try JSONDecoder().decode(T.self, from: data)
            }
            .handleEvents(receiveOutput: { [cache] output in
                cache[request] = output
            })
            .logErrors()
            .eraseToAnyPublisher()
    }
}

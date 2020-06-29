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
    @Locatable private var jsonDecoder: JSONDecoder

    func perform<T: Decodable>(request: Request) -> AnyPublisher<T, Error> {
        performData(request: request)
            .tryMap { [jsonDecoder] data in
                try jsonDecoder.decode(T.self, from: data)
            }
            .eraseToAnyPublisher()
    }

    func performData(request: Request) -> AnyPublisher<Data, Error> {
        guard let urlRequest = request.asURLRequest() else {
            return Fail<Data, Error>(error: RequestError.unableToCreateRequest)
                .eraseToAnyPublisher()
        }

        logger.debug(urlRequest.curlString)

        if let cached = cache[request] {
            return Result.Publisher(cached).eraseToAnyPublisher()
        }

        return urlSession.dataTaskPublisher(for: urlRequest)
            .retry(request.retryCount)
            .map(\.data)
            .handleEvents(receiveOutput: { [cache] data in
                cache[request] = data
            })
            .logErrors()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

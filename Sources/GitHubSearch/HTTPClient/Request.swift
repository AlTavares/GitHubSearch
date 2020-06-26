//
//  Request.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias QueryItems = [URLQueryItem]

struct Request: Hashable, CustomStringConvertible {
    var host: String
    var path: String
    var method: HTTPMethod = .get
    var queryItems: QueryItems = QueryItems()
    var headers: HTTPHeaders = HTTPHeaders()
    var shouldRetry: Bool = false
}

extension Request {
    var description: String {
        return "\(method.rawValue.uppercased()) \(host)\(path)"
    }

    func asURLRequest() -> URLRequest? {
        guard var components = URLComponents(string: host) else { return nil }
        components.path.append(path)
        components.queryItems = (components.queryItems ?? []) + queryItems
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.description
        request.allHTTPHeaderFields = headers
        return request
    }
}

extension QueryItems: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, String?)...) {
        self = elements.map { key, value in
            URLQueryItem(name: key, value: value)
        }
    }
}

//
//  GitHubServiceSearchParameters.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 27/06/20.
//

import Foundation

extension GitHubService {
    struct SearchParameters: Encodable {
        var term: SearchTerm
        var page: UInt = 0
        var itemsPerPage: UInt = 10
        var sorting: Sorting = .stars
        var order: Order = .descending

        enum CodingKeys: String, CodingKey {
            case term = "q"
            case page
            case itemsPerPage = "per_page"
            case sorting
            case order
        }
    }

    enum SearchTerm: Encodable {
        case language(String)

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(query)
        }

        var query: String {
            switch self {
            case let .language(value):
                return "language:\(value)"
            }
        }
    }

    enum Sorting: String, Encodable {
        case stars
        case forks
        case updated
    }

    enum Order: String, Encodable {
        case ascending
        case descending

        enum CodingKeys: String, CodingKey {
            case ascending = "asc"
            case descending = "desc"
        }
    }
}

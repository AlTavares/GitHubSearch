//
//  ValueState.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Foundation

enum ValueState<Value> {
    case idle
    case loading
    case loaded(Value)
    case error(Error)

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    var value: Value? {
        guard case let .loaded(value) = self else { return nil }
        return value
    }
}

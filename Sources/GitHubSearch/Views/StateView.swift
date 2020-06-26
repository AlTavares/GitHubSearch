//
//  StateView.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import SwiftUI

struct DefaultStateView<Value>: View {
    var state: ValueState<Value>
    var idleView: () -> AnyView
    var loadedView: (Value) -> AnyView
    var retryHandler: (() -> Void)?

    var body: some View {
        StateView<Value>(state: state,
                         idleView: idleView,
                         loadedView: loadedView,
                         loadingView: activityIndicator,
                         errorView: error)
    }

    private func activityIndicator() -> AnyView {
        ActivityIndicator(isAnimating: state.isLoading,
                          style: .large)
            .asAnyView()
    }

    private func error(_ error: Error) -> AnyView {
        ErrorView(error: error, retryHandler: retryHandler)
            .asAnyView()
    }
}

struct StateView<Value>: View {
    var state: ValueState<Value>
    var idleView: () -> AnyView
    var loadedView: (Value) -> AnyView
    var loadingView: () -> AnyView
    var errorView: (Error) -> AnyView

    var body: some View {
        Group<AnyView> {
            switch state {
            case .idle:
                return idleView()
            case .loading:
                return loadingView()
            case .error(let error):
                return errorView(error)
            case .loaded(let items):
                return loadedView(items)
            }
        }
    }
}

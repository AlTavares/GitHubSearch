//
//  RepositorySearchView.swift
//  GitHubSearchApp
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import SFSafeSymbols
import SwiftUI

struct RepositorySearchView: View {
    @ObservedObject var viewModel: RepositorySearchViewModel

    var body: some View {
        NavigationView {
            VStack {
                searchBar.padding([.leading, .bottom, .trailing])
                DefaultStateView(state: viewModel.state,
                                 idleView: emptyView,
                                 loadedView: list,
                                 errorView: { _ in self.emptyView() })
                    .frame(maxHeight: .infinity)
            }
            .navigationBarTitle(Text(L10n.View.Repository.Search.title),
                                displayMode: .large)
        }
    }

    var searchBar: some View {
        HStack {
            Image(systemSymbol: .magnifyingglass)
                .font(.system(size: 18, weight: .bold))
                .padding(2)
            TextField("", text: Binding(keyPath: \.searchTerm, on: viewModel))
                .modifier(PlaceholderStyle(showPlaceHolder: viewModel.searchTerm.isEmpty,
                                           placeholder: Text(L10n.View.Repository.SearchBar.placeholder))
                )
                .font(Font.caption.bold())
                .autocapitalization(.allCharacters)
        }
        .padding(8)
        .background(Color(.systemGray4))
        .foregroundColor(.white)
        .cornerRadius(10)
    }

    private func list(of items: [RepositoryViewData]) -> AnyView {
        guard items.count > 0 else {
            return emptyView()
        }
        return
            List(items) { item in
                NavigationLink(destination: ReadmeView(repositoryData: item)) {
                    RepositoryCellView(viewData: item)
                        .padding([.bottom, .top])
                        .onAppear {
                            self.itemDidAppear(item)
                        }
                }
            }.asAnyView()
    }

    func emptyView() -> AnyView {
        EmptyRepositoryView().asAnyView()
    }

    private func itemDidAppear(_ item: RepositoryViewData) {
        if viewModel.isLastItem(item) {
            viewModel.loadMore()
        }
    }
}

struct RepositorySearchView_Previews: PreviewProvider {
    static var previews: some View {
        RepositorySearchView(viewModel: RepositorySearchViewModel())
    }
}

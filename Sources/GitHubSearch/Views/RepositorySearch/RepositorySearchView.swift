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
        .onTapGesture {
            self.endEditing()
        }
    }

    var searchBar: some View {
        HStack {
            Image(systemSymbol: .magnifyingglass)
                .font(.system(size: 18, weight: .bold))
                .padding(2)
            TextField("", text: Binding(keyPath: \.searchTerm, on: viewModel))
                .modifier(PlaceholderStyle(showPlaceHolder: viewModel.searchTerm.isEmpty,
                                           placeholder: Text(L10n.View.Repository.SearchBar.placeholder.uppercased())))
                .font(Font.caption.bold())
                .autocapitalization(.allCharacters)
        }
        .padding(8)
        .background(Color(Asset.mediumGrey.name))
        .foregroundColor(.white)
        .cornerRadius(10)
    }

    private func list(of items: [RepositoryViewData]) -> AnyView {
        guard items.count > 0 else {
            return emptyView()
        }
        return List(items) { item in
            RepositoryCellView(viewData: item)
                .padding([.bottom, .top])
        }.asAnyView()
    }

    func emptyView() -> AnyView {
        EmptyRepositoryView().asAnyView()
    }
}

struct RepositorySearchView_Previews: PreviewProvider {
    static var previews: some View {
        RepositorySearchView(viewModel: RepositorySearchViewModel())
    }
}

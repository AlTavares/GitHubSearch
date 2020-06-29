//
//  ReadmeView.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 29/06/20.
//

import SwiftUI

struct ReadmeView: View {
    @ObservedObject var viewModel: ReadmeViewModel
    var body: some View {
        DefaultStateView(state: viewModel.state,
                         idleView: Color(.systemGray6).asAnyView,
                         loadedView: markdownView,
                         retryHandler: viewModel.load)
            .navigationBarTitle(Text(viewModel.repositoryData.name), displayMode: .inline)
            .onAppear(perform: viewModel.load)
    }

    private func markdownView(_ content: String) -> AnyView {
        MarkdownView(content: content)
            .asAnyView()
    }
}

extension ReadmeView {
    init(repositoryData: RepositoryViewData) {
        viewModel = .init(repositoryData: .init(from: repositoryData))
    }
}

struct ReadMeView_Previews: PreviewProvider {
    static var previews: some View {
        ReadmeView(viewModel: .init(repositoryData: RepositoryData(name: "GitHubSearch",
                                                                   owner: "AlTavares"))
        )
    }
}

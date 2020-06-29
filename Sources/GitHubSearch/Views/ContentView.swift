//
//  ContentView.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//  Copyright © 2020 Alexandre Mantovani Tavares. All rights reserved.
//

import SwiftUI
struct ContentView: View {
    var body: some View {
        RepositorySearchView(viewModel: RepositorySearchViewModel())
            .background(Color(.systemGray6))
        .foregroundColor(Color(.systemGray4))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

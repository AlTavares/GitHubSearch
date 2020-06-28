//
//  EmptyRepositoryView.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 28/06/20.
//

import SwiftUI

struct EmptyRepositoryView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(Asset.emojiSad.name)
                .renderingMode(.template)
                .resizable()
                .frame(width: 170, height: 170)

            Text(L10n.View.Repository.EmptyState.message.uppercased())
                .font(.caption)
                .bold()
        }.foregroundColor(Color(Asset.darkGrey.name))
    }
}

struct EmptyRepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyRepositoryView()
    }
}

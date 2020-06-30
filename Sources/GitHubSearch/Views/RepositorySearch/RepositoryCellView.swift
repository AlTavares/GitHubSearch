//
//  RepositoryCellView.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 28/06/20.
//

import SwiftUI

struct RepositoryCellView: View {
    let viewData: RepositoryViewData

    var body: some View {
        HStack(spacing: 30) {
            image
            repositoryInfo
        }
        .foregroundColor(Color(.systemGray2))
    }

    var repositoryInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(viewData.name.uppercased())
                .fontWeight(.semibold)
                .foregroundColor(Color(.label))
            Text(viewData.itemDescription.uppercased())
                .font(.caption)
                .fontWeight(.medium)
                .lineLimit(2)
            Spacer().frame(height: 4)
            HStack(spacing: 20) {
                stat(image: Image(systemSymbol: .starFill), count: viewData.stargazersCount)
                stat(image: Image(Asset.gitFork.name), count: viewData.forksCount)
            }
            Spacer().frame(height: 4)
            Text(viewData.owner.userName.uppercased())
                .font(.caption)
                .fontWeight(.semibold)
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray2), lineWidth: 2)
                )
        }
    }

    var image: some View {
        let placeholder = Image(systemSymbol: .personCropSquareFill)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .asAnyView()

        return URLImageView(url: viewData.owner.avatarURL, placeholder: placeholder)
            .frame(width: 120, height: 120)
            .cornerRadius(10)
    }

    func stat(image: Image, count: Int) -> some View {
        HStack {
            image
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15)
                .foregroundColor(Color(.label))
            Text(String(count))
                .font(.footnote)
                .fontWeight(.semibold)
        }
    }
}

struct RepositoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryCellView(viewData: .init(id: 0,
                                           name: "Repository",
                                           itemDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec accumsan mattis lacinia. Quisque rhoncus laoreet est, et mollis erat varius ultrices. Vestibulum sed sollicitudin nunc.",
                                           owner: .init(userName: "AlTavares",
                                                        avatarURL: "https://avatars1.githubusercontent.com/u/4191215"),
                                           stargazersCount: 10,
                                           forksCount: 5))
    }
}

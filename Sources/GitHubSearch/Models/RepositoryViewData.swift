//
//  RepositoryViewData.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 27/06/20.
//

import Foundation

struct RepositoryViewData: Equatable, Identifiable {
    let id: Int
    let name: String
    let itemDescription: String
    let owner: OwnerViewData
    let stargazersCount: Int
    let forksCount: Int
}

extension RepositoryViewData {
    init(from item: ResponseItem) {
        self.init(id: item.id,
                  name: item.name,
                  itemDescription: item.itemDescription ?? "",
                  owner: .init(from: item.owner),
                  stargazersCount: item.stargazersCount,
                  forksCount: item.forksCount)
    }
}

extension Array where Element == RepositoryViewData {
    init(from response: ResponseGitHubAPI) {
        self.init(response.items.map(RepositoryViewData.init))
    }
}

struct OwnerViewData: Equatable {
    let userName: String
    let avatarURL: String
}

extension OwnerViewData {
    init(from item: ResponseOwner) {
        self.init(userName: item.login, avatarURL: item.avatarURL)
    }
}

//
//  RepositoryViewData.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 29/06/20.
//

import Foundation

struct RepositoryData {
    var name: String
    var owner: String
}

extension RepositoryData {
    init(from item: RepositoryViewData) {
        self.init(name: item.name, owner: item.owner.userName)
    }
}

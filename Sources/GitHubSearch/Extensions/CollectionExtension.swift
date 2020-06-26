//
//  CollectionExtension.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Foundation

extension Array {
    func appending(_ element: Element) -> Self {
        var array = self
        array.append(element)
        return array
    }
}

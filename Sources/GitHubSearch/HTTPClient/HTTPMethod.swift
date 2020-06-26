//
//  HTTPMethod.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Foundation

enum HTTPMethod: String, CustomStringConvertible {
    case get, post, patch, put, delete

    var description: String {
        rawValue.uppercased()
    }
}

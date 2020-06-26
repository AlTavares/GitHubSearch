//
//  ErrorExtension.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Foundation

extension Error {
    var errorDescription: String? {
        (self as? LocalizedError)?.errorDescription
    }
}

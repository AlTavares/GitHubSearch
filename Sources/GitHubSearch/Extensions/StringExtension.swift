//
//  StringExtension.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 27/06/20.
//

import Foundation

extension String {
    func appending(path: String) -> String {
        (self as NSString).appendingPathComponent(path)
    }

    mutating func append(path: String) {
        self = appending(path: path)
    }
}

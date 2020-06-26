//
//  URLConvertible.swift
//  GitHubSearchApp
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Foundation

protocol URLConvertible {
    var url: URL? { get }
}

extension String: URLConvertible {
    var url: URL? { URL(string: self) }
}

extension URL: URLConvertible {
    var url: URL? { self }
}

extension Optional: URLConvertible where Wrapped: URLConvertible {
    var url: URL? { self?.url }
}

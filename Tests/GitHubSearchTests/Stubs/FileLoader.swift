//
//  FileLoader.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 27/06/20.
//

import Foundation
@testable import GitHubSearch

class File {
    @Locatable static var jsonDecoder: JSONDecoder
    struct FileNotFoundError: Error {}

    private init() {}

    class func load(name: String) throws -> Data {
        guard let path = Bundle(for: File.self).path(forResource: name, ofType: nil) else {
            throw FileNotFoundError()
        }
        return try Data(contentsOf: URL(fileURLWithPath: path))
    }
}

extension File {
    class func repositories() throws -> ResponseGitHubAPI {
        let json = try File.load(name: "repositories.json")
        return try jsonDecoder.decode(ResponseGitHubAPI.self, from: json)
    }
}

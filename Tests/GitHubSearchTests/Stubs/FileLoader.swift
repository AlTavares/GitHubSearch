//
//  FileLoader.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 27/06/20.
//

import Foundation
@testable import GitHubSearch

class File {
    struct FileNotFoundError: Error {}

    class func load(name: String) throws -> Data {
        guard let path = Bundle(for: File.self).path(forResource: name, ofType: nil) else {
            throw FileNotFoundError()
        }
        return try Data(contentsOf: URL(fileURLWithPath: path))
    }
}

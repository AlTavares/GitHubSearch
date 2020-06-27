//
//  EncodableExtension.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 27/06/20.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any] {
        let encoder = Locator.locate(JSONEncoder.self)
        guard let data = try? encoder.encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] ?? [:]
    }

    var queryItems: QueryItems {
        dictionary.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
    }
}

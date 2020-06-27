//
//  JSONDecoderExtension.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 27/06/20.
//

import Foundation

extension JSONDecoder {
    static var `default`: JSONDecoder {
        configure(JSONDecoder()) {
            $0.dateDecodingStrategy = .iso8601
        }
    }
}

extension JSONEncoder {
    static var `default`: JSONEncoder {
        configure(JSONEncoder()) {
            $0.dateEncodingStrategy = .iso8601
        }
    }
}

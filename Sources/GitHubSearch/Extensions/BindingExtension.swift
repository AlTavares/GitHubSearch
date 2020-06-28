//
//  BindingExtension.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 28/06/20.
//

import SwiftUI

extension Binding {
    init<A>(keyPath: ReferenceWritableKeyPath<A, Value>, on object: A) {
        self.init(
            get: { object[keyPath: keyPath] },
            set: { object[keyPath: keyPath] = $0 }
        )
    }
}

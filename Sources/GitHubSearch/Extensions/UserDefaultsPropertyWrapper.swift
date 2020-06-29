//
//  UserDefaultsPropertyWrapper.swift
//  GitHubSearch
//
//  Created by Alexandre Mantovani Tavares on 29/06/20.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value

    init(_ key: String, prefix: String = #function, defaultValue: Value) {
        self.key = "\(prefix).\(key)"
        self.defaultValue = defaultValue
    }

    var wrappedValue: Value {
        get {
            logger.trace("Getting UserDefaults property with key: \(key)")
            return UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            if isNil(newValue) {
                return UserDefaults.standard.removeObject(forKey: key)
            }
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }

    private func isNil(_ value: Value) -> Bool {
        String(describing: value) == "nil"
    }
}

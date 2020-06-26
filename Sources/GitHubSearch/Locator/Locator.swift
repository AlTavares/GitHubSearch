//
//  Locator.swift
//  RijksMuseum
//
//  Created by Alexandre Mantovani Tavares on 18/05/20.
//

import Foundation

public enum Locator {
    private static var factories: [ObjectIdentifier: () -> Any] = [:]

    public static func register<T>(_ type: T.Type = T.self, _ factory: @escaping () -> T) {
        logger.debug("\(type) registered")
        factories[ObjectIdentifier(type)] = factory
    }

    public static func register<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        register(type, factory)
    }

    public static func register<T>(_ factory: @autoclosure @escaping () -> T) {
        register(T.self, factory)
    }

    public static func locate<T>(_ type: T.Type) -> T {
        setup()
        let key = ObjectIdentifier(type)
        guard let factory = self.factories[key],
            let dependency = factory() as? T else {
            fatalError("Dependency of type `\(type)` was not found.")
        }
        return dependency
    }
}

@propertyWrapper
class Locatable<Dependency> {
    enum DependencyType {
        case ephemeral
        case stored
    }

    private let dependencyType: DependencyType
    init(_ dependencyType: DependencyType) {
        self.dependencyType = dependencyType
    }

    convenience init() {
        self.init(.stored)
    }

    private var dependency: Dependency?

    var wrappedValue: Dependency {
        switch dependencyType {
        case .ephemeral:
            return Locator.locate(Dependency.self)
        case .stored:
            if dependency == nil {
                dependency = Locator.locate(Dependency.self)
            }
            return dependency!
        }
    }
}

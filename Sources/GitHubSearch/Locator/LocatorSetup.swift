//
//  LocatorSetup.swift
//  RijksMuseum
//
//  Created by Alexandre Mantovani Tavares on 18/05/20.
//

import Foundation

extension Locator {
    static var setup: () -> Void = {
        logger.debug("Setting up dependencies")

        Locator.register(URLSession.shared)

        return {}
    }()
}

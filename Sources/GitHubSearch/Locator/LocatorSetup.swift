//
//  LocatorSetup.swift
//  RijksMuseum
//
//  Created by Alexandre Mantovani Tavares on 18/05/20.
//

import Foundation

extension Locator {
    private enum SharedInstances {
        static let imageCache = ImageCache()
        static let requestCache = RequestCache(entryLifetime: 5 * 60)
    }

    static var setup: () -> Void = {
        logger.debug("Setting up dependencies")

        Locator.register(URLSession.shared)
        Locator.register(HTTPClient.self, SimpleHTTPClient())
        Locator.register(GitHubSearchService.self, GitHubService())
        Locator.register(GitHubReadMeService.self, GitHubService())
        Locator.register(ImageLoader())

        Locator.register(JSONDecoder.default)
        Locator.register(JSONEncoder.default)

        Locator.register(SharedInstances.imageCache)
        Locator.register(SharedInstances.requestCache)

        return {}
    }()
}

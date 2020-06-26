//
//  CacheTests.swift
//  GitHubSearchTests
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

@testable import GitHubSearch
import Nimble
import Quick
import XCTest

class CacheTests: QuickSpec {
    override func spec() {
        describe("a cache") {
            let cache = Cache<String, String>()
            let key = "key"
            let value = "value"
            it("caches a value") {
                cache.insert(value, forKey: key)
                expect(cache.value(forKey: key)) == value
            }
            it("deletes the value") {
                cache.removeValue(forKey: key)
                expect(cache.value(forKey: key)).to(beNil())
            }
        }
        describe("a cache with expiration") {
            let dateProvider = DateProvider()
            let cache = Cache<String, String>(dateProvider: dateProvider.date, entryLifetime: 60)
            let key = "key"
            let value = "value"
            it("caches a value") {
                cache.insert(value, forKey: key)
                expect(cache.value(forKey: key)) == value
            }
            it("deletes the value after lifetime expires") {
                dateProvider.date = Date().addingTimeInterval(100)
                expect(cache.value(forKey: key)).to(beNil())
            }
        }
    }
}

private class DateProvider {
    var date = Date()
}

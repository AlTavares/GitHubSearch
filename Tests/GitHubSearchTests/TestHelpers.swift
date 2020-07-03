//
//  TestHelpers.swift
//  GitHubSearchTests
//
//  Created by Alexandre Mantovani Tavares on 30/06/20.
//

import Combine
@testable import GitHubSearch
import Nimble
import Quick
import SnapshotTesting
import SwiftUI
import XCTest

func assertSnapshot<Value: View>(matching view: Value,
                                 named name: String,
                                 record recording: Bool = false,
                                 timeout: TimeInterval = 5,
                                 file: StaticString = #file,
                                 testName: String = #function,
                                 line: UInt = #line) {
    let localeIDs: [String] = [
        "pt_BR",
        "en_US",
    ]

    localeIDs.forEach { localeID in
        let view = view.environment(\.locale, Locale(identifier: localeID))
        let viewController = UIHostingController(rootView: view)
        assertSnapshot(matching: viewController,
                       as: .image(on: .iPhoneXr),
                       named: "\(name)-\(localeID)",
                       record: recording,
                       timeout: timeout,
                       file: file,
                       testName: testName,
                       line: line)
    }
}

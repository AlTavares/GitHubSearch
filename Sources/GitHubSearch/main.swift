//
//  main.swift
//  GitHubSearchTests
//
//  Created by Alexandre Mantovani Tavares on 30/06/20.
//

import Foundation
import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass = isRunningTests ? nil : NSStringFromClass(AppDelegate.self)
Locator.setup()
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, appDelegateClass)

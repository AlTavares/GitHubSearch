//
//  Logger.swift
//  GitHubSearchApp
//
//  Created by Alexandre Mantovani Tavares on 26/06/20.
//

import Foundation
import Logging

let logger = configure(Logger(label: Bundle.main.bundleIdentifier!)) {
    $0.logLevel = .trace
}

extension Logger {
    func trace(_ message: Any,
               file: String = #file,
               function: String = #function,
               line: UInt = #line) {
        trace(Message("\(message)"), file: file, function: function, line: line)
    }

    func debug(_ message: Any,
               file: String = #file,
               function: String = #function,
               line: UInt = #line) {
        debug(Message("\(message)"), file: file, function: function, line: line)
    }

    func info(_ message: Any,
              file: String = #file,
              function: String = #function,
              line: UInt = #line) {
        info(Message("\(message)"), file: file, function: function, line: line)
    }

    func notice(_ message: Any,
                file: String = #file,
                function: String = #function,
                line: UInt = #line) {
        notice(Message("\(message)"), file: file, function: function, line: line)
    }

    func warning(_ message: Any,
                 file: String = #file,
                 function: String = #function,
                 line: UInt = #line) {
        warning(Message("\(message)"), file: file, function: function, line: line)
    }

    func error(_ message: Any,
               file: String = #file,
               function: String = #function,
               line: UInt = #line) {
        error(Message("\(message)"), file: file, function: function, line: line)
    }

    func critical(_ message: Any,
                  file: String = #file,
                  function: String = #function,
                  line: UInt = #line) {
        critical(Message("\(message)"), file: file, function: function, line: line)
    }
}

import Combine
extension Publisher {
    func logErrors() -> Publishers.HandleEvents<Self> {
        handleEvents(receiveCompletion: { completion in
            guard case .failure(let error) = completion else { return }
            logger.error(error)
        })
    }
}

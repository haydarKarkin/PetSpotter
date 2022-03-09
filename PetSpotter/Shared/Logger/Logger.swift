//
//  Logger.swift
//  PetSpotter
//
//  Created by turyunus on 7.03.2022.
//

import Foundation
import os

public final class Logger {
    private static let log = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "", category: "LOG")
    private init() {}
}

// MARK: - Levels
extension Logger {
    
    /// Logs a string at the `debug` level.
    ///
    /// - Warning: Level of `debug` is not persisted.
    ///
    /// - Parameters:
    ///   - message: A string.
    public static func debug(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, type: .debug, file: file, function: function, line: line)
    }
    
    /// Logs a string at the `error` level.
    ///
    /// - Warning: Level of `error` is persisted.
    ///
    /// - Parameters:
    ///   - message: A string.
    public static func error(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, type: .fault, file: file, function: function, line: line)
    }
    
    /// Logs a string at the `info` level.
    ///
    /// - Warning: Level of `info` is only persisted during `log collect` option.
    ///
    /// - Parameters:
    ///   - message: A string.
    public static func info(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, type: .info, file: file, function: function, line: line)
    }
    
    /// Logs a string at the `verbose` level.
    ///
    /// - Warning: Level of `verbose` is persisted.
    ///
    /// - Parameters:
    ///   - message: A string.
    public static func verbose(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, type: .default, file: file, function: function, line: line)
    }
    
    /// Logs a string at the `warning` level.
    ///
    /// - Warning: Level of `warning` is persisted.
    ///
    /// - Parameters:
    ///   - message: A string.
    public static func warning(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, type: .error, file: file, function: function, line: line)
    }
}

// MARK: - Logic
private extension Logger {
    
     static func log(_ message: String, type: OSLogType, file: StaticString, function: StaticString, line: UInt) {
        let message = getMessage(message, type: type, file: file, function: function, line: line)
        os_log("%@", log: log, type: type, message)
    }
    
    static func getMessage(_ message: String, type: LogTypeProtocol, file: StaticString, function: StaticString, line: UInt) -> String {
        return "\n\(type.logTypeIndicator.rawValue) [\(type.logTypeName.rawValue)] [\(URL(fileURLWithPath: String(describing: file)).lastPathComponent)] [\(function)] [\(line)] [\(message)]"
    }
}

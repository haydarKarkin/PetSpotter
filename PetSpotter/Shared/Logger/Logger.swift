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
    private static var configuration: LoggerConfiguration = .default
    private init() {}
}

// MARK: - Configure
public extension Logger {
    
    static func configure(with configuration: LoggerConfiguration) {
        Logger.configuration = configuration
    }
}

// MARK: - Levels
public extension Logger {
    
    /// Logs a string at the `verbose` level.
    ///
    /// - Warning: Level of `verbose` is persisted.
    ///
    /// - Parameters:
    ///   - message: A string.
    static func verbose(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, level: .verbose, file: file, function: function, line: line)
    }
    
    /// Logs a string at the `debug` level.
    ///
    /// - Warning: Level of `debug` is not persisted.
    ///
    /// - Parameters:
    ///   - message: A string.
    static func debug(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, level: .debug, file: file, function: function, line: line)
    }
    
    /// Logs a string at the `info` level.
    ///
    /// - Warning: Level of `info` is only persisted during `log collect` option.
    ///
    /// - Parameters:
    ///   - message: A string.
    static func info(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, level: .info, file: file, function: function, line: line)
    }
    
    /// Logs a string at the `warning` level.
    ///
    /// - Warning: Level of `warning` is persisted.
    ///
    /// - Parameters:
    ///   - message: A string.
    static func warning(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, level: .warning, file: file, function: function, line: line)
    }
    
    /// Logs a string at the `error` level.
    ///
    /// - Warning: Level of `error` is persisted.
    ///
    /// - Parameters:
    ///   - message: A string.
    static func error(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, level: .error, file: file, function: function, line: line)
    }
}

// MARK: - Logic
private extension Logger {
    
     static func log(_ message: String, level: LogLevel, file: StaticString, function: StaticString, line: UInt) {
         guard level >= configuration.minimumLogLevel else { return }
         let message = getMessage(message, level: level, file: file, function: function, line: line)
         os_log("%@", log: log, type: level.osLogType, message)
    }
    
    static func getMessage(_ message: String, level: LogLevel, file: StaticString, function: StaticString, line: UInt) -> String {
        return "\n\(level.indicator) [\(level.name)] [\(URL(fileURLWithPath: String(describing: file)).lastPathComponent)] [\(function)] [\(line)] [\(message)]"
    }
}

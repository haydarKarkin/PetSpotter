//
//  Logger.swift
//  PetSpotter
//
//  Created by turyunus on 7.03.2022.
//

import Foundation
import OSLog

public final class Logger {
    private static let logger = os.Logger.init(subsystem: Bundle.main.bundleIdentifier ?? "", category: "LOG")
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
        log(message, level: .debug, file: file, function: function, line: line)
    }
    
    /// Logs a string at the `error` level.
    ///
    /// - Warning: Level of `error` is persisted.
    ///
    /// - Parameters:
    ///   - message: A string.
    public static func error(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, level: .error, file: file, function: function, line: line)
    }
    
    /// Logs a string at the `info` level.
    ///
    /// - Warning: Level of `info` is only persisted during `log collect` option.
    ///
    /// - Parameters:
    ///   - message: A string.
    public static func info(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, level: .info, file: file, function: function, line: line)
    }
    
    /// Logs a string at the `verbose` level.
    ///
    /// - Warning: Level of `verbose` is persisted.
    ///
    /// - Parameters:
    ///   - message: A string.
    public static func verbose(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, level: .default, file: file, function: function, line: line)
    }
    
    /// Logs a string at the `warning` level.
    ///
    /// - Warning: Level of `warning` is persisted.
    ///
    /// - Parameters:
    ///   - message: A string.
    public static func warning(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(message, level: .fault, file: file, function: function, line: line)
    }
}

// MARK: - Logic
extension Logger {
    
    private static func log(_ message: String, level: OSLogType, file: StaticString, function: StaticString, line: UInt) {
        let message = getMessage(message, type: level, file: file, function: function, line: line)
        Logger.logger.log(level: level, "\(message)")
    }
    
    private static func getMessage(_ message: String, type: LogTypeProtocol, file: StaticString, function: StaticString, line: UInt) -> String {
        return "\n\(type.logTypeIndicator.rawValue) [\(type.logTypeName.rawValue)] [\(URL(fileURLWithPath: String(describing: file)).lastPathComponent)] [\(function)] [\(line)]\n[\(message)]"
    }
}

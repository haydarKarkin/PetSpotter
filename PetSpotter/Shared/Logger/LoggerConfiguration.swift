//
//  LoggerConfiguration.swift
//  PetSpotter
//
//  Created by turyunus on 9.03.2022.
//

import Foundation

public struct LoggerConfiguration {
    var minimumLogLevel: LogLevel
    
    init(minimumLogLevel: LogLevel = .verbose) {
        self.minimumLogLevel = minimumLogLevel
    }
}

// MARK: - Static
public extension LoggerConfiguration {
    static let `default`: LoggerConfiguration = LoggerConfiguration()
}

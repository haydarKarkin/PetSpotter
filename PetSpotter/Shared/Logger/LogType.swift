//
//  LogType.swift
//  PetSpotter
//
//  Created by turyunus on 7.03.2022.
//

import Foundation

protocol LogTypeProtocol {
    var logTypeIndicator: LogTypeIndicator { get }
    var logTypeName: LogTypeName { get }
}

enum LogTypeIndicator: String {
    case debug = "🐞"
    case error = "🚨"
    case info = "ℹ️"
    case verbose = "🌐"
    case warning = "⚠️"
}

enum LogTypeName: String {
    case debug = "DEBUG"
    case error = "ERROR"
    case info = "INFO"
    case verbose = "VERBOSE"
    case warning = "WARNING"
}

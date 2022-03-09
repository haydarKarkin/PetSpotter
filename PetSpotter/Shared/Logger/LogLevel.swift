//
//  LogLevel.swift
//  PetSpotter
//
//  Created by turyunus on 7.03.2022.
//

import Foundation

enum LogLevel: Int {
    case verbose = 1
    case debug = 2
    case info = 3
    case warning = 4
    case error = 5
    
    var indicator: String {
        switch self {
        case .verbose: return "🌐"
        case .debug: return "🐞"
        case .info: return "ℹ️"
        case .warning: return "⚠️"
        case .error: return "🚨"
        }
    }
    
    var name: String {
        switch self {
        case .verbose: return "VERBOSE"
        case .debug: return "DEBUG"
        case .info: return "INFO"
        case .warning: return "WARNING"
        case .error: return "ERROR"
        }
    }
}

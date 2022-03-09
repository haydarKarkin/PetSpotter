//
//  LogLevel+OSLogType.swift
//  PetSpotter
//
//  Created by turyunus on 8.03.2022.
//

import Foundation
import OSLog

extension LogLevel {
    
    var osLogType: OSLogType {
        switch self {
        case .verbose: return .default
        case .debug: return .debug
        case .info: return .info
        case .warning: return .default
        case .error: return .error
        }
    }
}

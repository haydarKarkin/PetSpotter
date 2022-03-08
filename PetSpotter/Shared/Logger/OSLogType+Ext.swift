//
//  OSLogType+Ext.swift
//  PetSpotter
//
//  Created by turyunus on 8.03.2022.
//

import Foundation
import OSLog

extension OSLogType: LogTypeProtocol {
    
    var logTypeIndicator: LogTypeIndicator {
        switch self {
        case .debug: return .debug
        case .error: return .error
        case .fault: return .warning
        case .info: return .info
        case .default: return .verbose
        default: return .verbose
        }
    }
    
    var logTypeName: LogTypeName {
        switch self {
        case .debug: return .debug
        case .error: return .error
        case .fault: return .warning
        case .info: return .info
        case .default: return .verbose
        default: return .verbose
        }
    }
}

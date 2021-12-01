//
//  OnboardingAPI.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import Foundation

enum OnboardingAPI {
    case token
}

extension OnboardingAPI: TargetType {
    var baseURL: String {
        return Environment.rootURL.absoluteString
    }
    
    var path: String {
        switch self {
        case .token:
            return "/oauth2/token"
        }
    }
    
    var parameters: [String: Any]? {
        
        var params: [String: Any] = [:]
        return params
    }
    
    var method: TargetMethod {
        switch self {
        case .token:
            return .get
        }
    }
}

// MARK: - Sample Data
extension OnboardingAPI {
    var sampleData: Data {
        switch self {
        case .token: return "Token".data(using: .utf8)!
        }
    }
}

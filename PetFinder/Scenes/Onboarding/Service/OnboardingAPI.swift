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
    
    var version: String {
        return "/v2"
    }
    
    var path: String {
        switch self {
        case .token:
            return "/oauth2/token"
        }
    }
    
    var shouldAuth: Bool {
        return false
    }
    
    var parameters: [String: Any]? {
        
        var params: [String: Any] = [:]
        
        switch self {
        case .token:
            params["grant_type"] = "client_credentials"
            params["client_id"] = Environment.apiKey
            params["client_secret"] = Environment.secret
        }
        
        return params
    }
    
    var method: TargetMethod {
        switch self {
        case .token:
            return .post
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

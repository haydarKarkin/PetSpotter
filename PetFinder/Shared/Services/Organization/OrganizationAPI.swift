//
//  OrganizationAPI.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import Foundation

enum OrganizationAPI {
    case organizations(perPage: Int, page: Int)
    case organization(id: String)
}

extension OrganizationAPI: TargetType {
    var baseURL: String {
        return Environment.rootURL.absoluteString
    }
    
    var version: String {
        return "/v2"
    }
    
    var path: String {
        switch self {
        case .organizations:
            return "/organizations"
        case .organization(let id):
            return "/organizations/\(id)"
        }
    }
    
    var shouldAuth: Bool {
        return true
    }
    
    var parameters: [String: Any]? {
        
        var params: [String: Any] = [:]
        
        switch self {
        case .organizations(let perPage, let page):
            params["limit"] = perPage
            params["page"] = page
        default:
            break
        }
        
        return params
    }
    
    var method: TargetMethod {
        switch self {
        case .organizations, .organization:
            return .get
        }
    }
}

// MARK: - Sample Data
extension OrganizationAPI {
    var sampleData: Data {
        switch self {
        case .organizations: return "Organizations".data(using: .utf8)!
        case .organization: return "Organization".data(using: .utf8)!
        }
    }
}

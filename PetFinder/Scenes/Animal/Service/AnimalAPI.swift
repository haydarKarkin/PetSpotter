//
//  AnimalAPI.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

enum AnimalAPI {
    case animals
    case animal(id: String)
}

extension AnimalAPI: TargetType {
    var baseURL: String {
        return Environment.rootURL.absoluteString
    }
    
    var version: String {
        return "/v2"
    }
    
    var path: String {
        switch self {
        case .animals:
            return "/animals"
        case .animal(let id):
            return "/animals/\(id)"
        }
    }
    
    var shouldAuth: Bool {
        return true
    }
    
    var parameters: [String: Any]? {
        
        var params: [String: Any] = [:]
        return params
    }
    
    var method: TargetMethod {
        switch self {
        case .animals, .animal:
            return .get
        }
    }
}

// MARK: - Sample Data
extension AnimalAPI {
    var sampleData: Data {
        switch self {
        case .animals: return "Animals".data(using: .utf8)!
        case .animal: return "Animal".data(using: .utf8)!
        }
    }
}

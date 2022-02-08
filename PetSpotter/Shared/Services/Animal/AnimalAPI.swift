//
//  AnimalAPI.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

enum AnimalAPI {
    case animals(perPage: Int, page: Int, organizationID: String?, type: String?, breed: String?, size: String?, gender: String?)
    case animalsByLocation(location: String)
    case animal(id: String)
    case types
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
        case .animals, .animalsByLocation:
            return "/animals"
        case .animal(let id):
            return "/animals/\(id)"
        case .types:
            return "/types"
        }
    }
    
    var shouldAuth: Bool {
        return true
    }
    
    var parameters: [String: Any]? {
        
        var params: [String: Any] = [:]
        
        switch self {
        case let .animals(perPage, page, organizationID, type, breed, size, gender):
            params["limit"] = perPage
            params["page"] = page
            if let organizationID = organizationID {
                params["organization"] = organizationID
            }
            if let type = type {
                params["type"] = type
            }
            if let breed = breed {
                params["breed"] = breed
            }
            if let size = size {
                params["size"] = size
            }
            if let gender = gender {
                params["gender"] = gender
            }
        case .animalsByLocation(let location):
            params["location"] = location
        default:
            break
        }
        
        return params
    }
    
    var method: TargetMethod {
        switch self {
        case .animals, .animalsByLocation, .animal, .types:
            return .get
        }
    }
}

// MARK: - Sample Data
extension AnimalAPI {
    var sampleData: Data {
        switch self {
        case .animals: return "Animals".data(using: .utf8)!
        case .animalsByLocation: return "AnimalsByLocation".data(using: .utf8)!
        case .animal: return "Animal".data(using: .utf8)!
        case .types : return "Types".data(using: .utf8)!
        }
    }
}

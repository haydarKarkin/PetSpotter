//
//  AnimalAPI.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

enum AnimalAPI {
    case animals(perPage: Int, page: Int, organizationID: String?, filter: Filter?)
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
        case let .animals(perPage, page, organizationID, filter):
            params["limit"] = perPage
            params["page"] = page
            if let organizationID = organizationID {
                params["organization"] = organizationID
            }
            if let filter = filter {
                params.merge(filter.makeParameters()){ (current, _) in current }
            }
            print(params)
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

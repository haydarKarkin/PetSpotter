//
//  Filter.swift
//  PetFinder
//
//  Created by hkarkin on 9.02.2022.
//

import Foundation

struct Filter {
    var name: String? = nil
    var ages: [String] = []
    var sizes: [String] = []
    var genders: [String] = []
    var coats: [String] = []
    var statuses: [String] = []
    var others: [String: Bool] = [:]
}

extension Filter {
    
    func makeParameters() -> [String: Any] {
        var params: [String: Any] = [:]
       
        if let name = name {
            params["name"] = name
        }
        if !ages.isEmpty {
            params["age"] = ages.joined(separator:", ")
        }
        if !sizes.isEmpty {
            params["size"] = sizes.joined(separator:", ")
        }
        if !genders.isEmpty {
            params["gender"] = genders.joined(separator:", ")
        }
        if !statuses.isEmpty {
            params["status"] = statuses.joined(separator:", ")
        }
        if !coats.isEmpty {
            params["coat"] = coats.joined(separator:", ")
        }
        others.forEach {
            params[$0.key] = $0.value
        }
        return params
    }
}

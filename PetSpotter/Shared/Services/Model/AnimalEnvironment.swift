//
//  AnimalEnvironment.swift
//  PetFinder
//
//  Created by hkarkin on 5.02.2022.
//

import Foundation

// MARK: - Environment
struct AnimalEnvironment: Codable {
    let children, dogs, cats: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.children = try container.decodeIfPresent(Bool.self, forKey: .children) ?? false
        self.dogs = try container.decodeIfPresent(Bool.self, forKey: .dogs) ?? false
        self.cats = try container.decodeIfPresent(Bool.self, forKey: .cats) ?? false
    }
}

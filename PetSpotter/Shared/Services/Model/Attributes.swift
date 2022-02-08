//
//  Attributes.swift
//  PetFinder
//
//  Created by hkarkin on 5.02.2022.
//

import Foundation

// MARK: - Attributes
struct Attributes: Codable {
    let spayedNeutered, houseTrained, declawed, specialNeeds: Bool
    let shotsCurrent: Bool
    
    enum CodingKeys: String, CodingKey {
        case spayedNeutered = "spayed_neutered"
        case houseTrained = "house_trained"
        case declawed
        case specialNeeds = "special_needs"
        case shotsCurrent = "shots_current"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.spayedNeutered = try container.decodeIfPresent(Bool.self, forKey: .spayedNeutered) ?? false
        self.houseTrained = try container.decodeIfPresent(Bool.self, forKey: .houseTrained) ?? false
        self.declawed = try container.decodeIfPresent(Bool.self, forKey: .declawed) ?? false
        self.specialNeeds = try container.decodeIfPresent(Bool.self, forKey: .specialNeeds) ?? false
        self.shotsCurrent = try container.decodeIfPresent(Bool.self, forKey: .shotsCurrent) ?? false
    }
}

//
//  AnimalType.swift
//  PetFinder
//
//  Created by hkarkin on 24.01.2022.
//

import Foundation

// MARK: - AnimalType
struct AnimalType: Codable {
    let name: String
    let coats, colors, genders: [String]
}

//
//  Breeds.swift
//  PetFinder
//
//  Created by hkarkin on 5.02.2022.
//

import Foundation

// MARK: - Breeds
struct Breeds: Codable {
    let primary: String?
    let secondary: String?
    let mixed, unknown: Bool
}

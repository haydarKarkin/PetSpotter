//
//  Address.swift
//  PetFinder
//
//  Created by hkarkin on 24.01.2022.
//

import Foundation

// MARK: - Address
struct Address: Codable {
    
    let address1: String?
    let address2: String?
    let city: String?
    let state: String?
    let postcode: String?
    let country: String?
}

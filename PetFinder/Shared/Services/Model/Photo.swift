//
//  Photo.swift
//  PetFinder
//
//  Created by hkarkin on 24.01.2022.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    
    let small: String?
    let medium: String?
    let large: String?
    let full: String?
}

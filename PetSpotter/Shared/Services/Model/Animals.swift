//
//  Animals.swift
//  PetFinder
//
//  Created by hkarkin on 10.12.2021.
//

import Foundation

struct Animals: Codable {
    let animals: [Animal]?
    let pagination: Pagination?
}

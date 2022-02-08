//
//  Contact.swift
//  PetFinder
//
//  Created by hkarkin on 5.02.2022.
//

import Foundation

// MARK: - Contact
struct Contact: Codable {
    let email, phone: String?
    let address: Address?
}

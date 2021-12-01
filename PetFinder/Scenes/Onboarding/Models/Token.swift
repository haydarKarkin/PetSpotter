//
//  Token.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import Foundation

// MARK: - LicenseModel
struct Token: Codable {
    let token: String
    let tokenType: String
    let expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}

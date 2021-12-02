//
//  Token.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import Foundation

// MARK: - Token
struct Token: Codable {
    let token: String
    let tokenType: String
    let expiresIn: Date
    
    //MARK: Life Cycle
    
    init(token: String, tokenType: String, expiresIn: Date) {
        self.token = token
        self.tokenType = tokenType
        self.expiresIn = expiresIn
    }
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let token = try container.decode(String.self, forKey: .token)
        let tokenType =  try container.decode(String.self, forKey: .tokenType)
        let expiresIn = try container.decode(Int.self, forKey: .expiresIn)
        let tokenExpirationDate = Date().adding(seconds: expiresIn)
        self.init(token: token, tokenType: tokenType, expiresIn: tokenExpirationDate)
    }
    
    //MARK: CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}

extension Token {
    func isTokenValid() -> Bool {
        let tokenDate = expiresIn
        let isValid = Date() < tokenDate && !token.isEmpty
        print("\n\(#function) = \(isValid)")
        return isValid
    }
}

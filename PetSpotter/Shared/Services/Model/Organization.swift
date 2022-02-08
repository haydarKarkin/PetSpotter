//
//  Organization.swift
//  PetFinder
//
//  Created by hkarkin on 24.01.2022.
//

import Foundation

// MARK: - Animal
struct Organization: Codable {
    
    let id: String
    let name: String?
    let email: String?
    let phone: String?
    let address: Address?
    let hours: Hours?
    let url: String?
    let website: String?
    let missionStatement: String?
    let adoption: Adoption?
    let socialMedia: SocialMedia?
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case phone
        case address
        case hours
        case url
        case website
        case missionStatement = "mission_statement"
        case adoption
        case socialMedia = "social_media"
        case photos
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.address = try container.decodeIfPresent(Address.self, forKey: .address)
        self.hours = try container.decodeIfPresent(Hours.self, forKey: .hours)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.website = try container.decodeIfPresent(String.self, forKey: .website)
        self.missionStatement = try container.decodeIfPresent(String.self, forKey: .missionStatement)
        self.adoption = try container.decodeIfPresent(Adoption.self, forKey: .adoption)
        self.socialMedia = try container.decodeIfPresent(SocialMedia.self, forKey: .socialMedia)
        self.photos = try container.decodeIfPresent([Photo].self, forKey: .photos) ?? []
    }
    
    public func encode(to encoder: Encoder) throws {}
}

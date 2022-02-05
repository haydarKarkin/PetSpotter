//
//  Animal.swift
//  PetFinder
//
//  Created by hkarkin on 10.12.2021.
//

import Foundation

// MARK: - Animal
struct Animal: Codable {
    
    let id: Int
    let organizationID: String?
    let url: String?
    let type: String?
    let species: String?
    let age: String?
    let gender: String?
    let size: String?
    let coat: String?
    let name: String?
    let animalDescription: String?
    let status: String?
    let publishedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case organizationID = "organization_id"
        case url
        case type
        case species
        case breeds
        case age
        case gender
        case size
        case coat
        case name
        case animalDescription = "description"
        case status
        case environment
        case publishedAt = "published_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.organizationID = try container.decodeIfPresent(String.self, forKey: .organizationID)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.species = try container.decodeIfPresent(String.self, forKey: .species)
        self.age = try container.decodeIfPresent(String.self, forKey: .age)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.size = try container.decodeIfPresent(String.self, forKey: .size)
        self.coat = try container.decodeIfPresent(String.self, forKey: .coat)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.animalDescription = try container.decodeIfPresent(String.self, forKey: .animalDescription)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        let stringDate = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        let formatter = DateFormatter.yyyyMMdd
        if let date = formatter.date(from: stringDate!) {
            self.publishedAt = date
        } else {
            self.publishedAt = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {}
}

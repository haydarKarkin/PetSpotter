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
    let breeds: Breeds?
    let colors: Colors?
    let age: String?
    let gender: String?
    let size: String?
    let coat: String?
    let name: String?
    let animalDescription: String?
    let status: String?
    let attributes: Attributes?
    let environment: AnimalEnvironment?
    let publishedAt: Date?
    let photos: [Photo]
    let tags: [String]
    let contact: Contact?
    let videos: [Video]
    
    enum CodingKeys: String, CodingKey {
        case id
        case organizationID = "organization_id"
        case url
        case type
        case species
        case breeds
        case colors
        case age
        case gender
        case size
        case coat
        case name
        case animalDescription = "description"
        case status
        case attributes
        case environment
        case publishedAt = "published_at"
        case photos
        case tags
        case contact
        case videos
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.organizationID = try container.decodeIfPresent(String.self, forKey: .organizationID)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.species = try container.decodeIfPresent(String.self, forKey: .species)
        self.breeds = try container.decodeIfPresent(Breeds.self, forKey: .breeds)
        self.colors = try container.decodeIfPresent(Colors.self, forKey: .colors)
        self.age = try container.decodeIfPresent(String.self, forKey: .age)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.size = try container.decodeIfPresent(String.self, forKey: .size)
        self.coat = try container.decodeIfPresent(String.self, forKey: .coat)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.animalDescription = try container.decodeIfPresent(String.self, forKey: .animalDescription)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.attributes = try container.decodeIfPresent(Attributes.self, forKey: .attributes)
        self.environment = try container.decodeIfPresent(AnimalEnvironment.self, forKey: .environment)
        self.contact = try container.decodeIfPresent(Contact.self, forKey: .contact)
        
        let stringDate = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        let formatter = DateFormatter.yyyyMMdd
        if let date = formatter.date(from: stringDate!) {
            self.publishedAt = date
        } else {
            self.publishedAt = nil
        }
        self.photos = try container.decodeIfPresent([Photo].self, forKey: .photos) ?? []
        self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
        self.videos = try container.decodeIfPresent([Video].self, forKey: .videos) ?? []
        
        if !self.videos.isEmpty {
            print(name)
        }
    }
    
    public func encode(to encoder: Encoder) throws {}
}

//
//  OrganizationService.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import Foundation

protocol OrganizationServiceType {
}

class OrganizationService: OrganizationServiceType {
    
    let provider: ClientProvider<OrganizationAPI>
    
    init(provider: ClientProvider<OrganizationAPI>) {
        self.provider = provider
    }
}

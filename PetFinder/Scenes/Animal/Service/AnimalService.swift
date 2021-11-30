//
//  AnimalService.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

protocol AnimalServiceType {
}

class AnimalService: AnimalServiceType {
    
    let provider: ClientProvider<AnimalAPI>
    
    init(provider: ClientProvider<AnimalAPI>) {
        self.provider = provider
    }
}

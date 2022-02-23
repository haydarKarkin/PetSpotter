//
//  ServiceFactory.swift
//  PetSpotter
//
//  Created by turyunus on 23.02.2022.
//

import Foundation

protocol ServiceFactoryType {
    func makeAnimalService() -> AnimalServiceType
    func makeFavoriteService() -> FavoriteServiceType
    func makeOnboardingService() -> OnboardingServiceType
    func makeOrganizationService() -> OrganizationServiceType
}

class ServiceFactory: ServiceFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
}

extension ServiceFactory {
    
    func makeAnimalService() -> AnimalServiceType {
        let clientProvider: ClientProvider<AnimalAPI> = sharedFactory.makeClientProvider()
        return AnimalService(provider: clientProvider)
    }
    
    func makeFavoriteService() -> FavoriteServiceType {
        return FavoriteService()
    }
    
    func makeOnboardingService() -> OnboardingServiceType {
        let clientProvider: ClientProvider<OnboardingAPI> = sharedFactory.makeClientProvider()
        return OnboardingService(provider: clientProvider)
    }
    
    func makeOrganizationService() -> OrganizationServiceType {
        let clientProvider: ClientProvider<OrganizationAPI> = sharedFactory.makeClientProvider()
        return OrganizationService(provider: clientProvider)
    }
}

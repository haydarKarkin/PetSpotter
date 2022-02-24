//
//  ServiceFactory.swift
//  PetSpotter
//
//  Created by turyunus on 23.02.2022.
//

import Foundation

protocol ServiceFactoryType {
    func makeClientProvider<T: TargetType>(shouldStub: StubType) -> ClientProvider<T>
    func makeAnimalService() -> AnimalServiceType
    func makeFavoriteService() -> FavoriteServiceType
    func makeOnboardingService() -> OnboardingServiceType
    func makeOrganizationService() -> OrganizationServiceType
}

extension ServiceFactoryType {
    
    func makeClientProvider<T: TargetType>(shouldStub: StubType = .never) -> ClientProvider<T> {
        return makeClientProvider(shouldStub: shouldStub)
    }
}

class ServiceFactory: ServiceFactoryType {
    
    func makeClientProvider<T: TargetType>(shouldStub: StubType) -> ClientProvider<T> {
        return ClientProvider<T>(shouldStub: shouldStub)
    }
    
    func makeAnimalService() -> AnimalServiceType {
        let clientProvider: ClientProvider<AnimalAPI> = makeClientProvider()
        return AnimalService(provider: clientProvider)
    }
    
    func makeFavoriteService() -> FavoriteServiceType {
        return FavoriteService()
    }
    
    func makeOnboardingService() -> OnboardingServiceType {
        let clientProvider: ClientProvider<OnboardingAPI> = makeClientProvider()
        return OnboardingService(provider: clientProvider)
    }
    
    func makeOrganizationService() -> OrganizationServiceType {
        let clientProvider: ClientProvider<OrganizationAPI> = makeClientProvider()
        return OrganizationService(provider: clientProvider)
    }
}

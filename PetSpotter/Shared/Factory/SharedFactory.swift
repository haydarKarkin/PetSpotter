//
//  SharedFactory.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

protocol SharedFactoryType {
    func makeServiceFactory() -> ServiceFactoryType
    func makeHomeFactory() -> HomeFactoryType
    func makeAnimalFactory() -> AnimalFactoryType
    func makeOrganizationFactory() -> OrganizationFactoryType
    func makeOnboardingFactory() -> OnboardingFactoryType
    func makeFavoriteFactory() -> FavoriteFactoryType
    func makeAnimalMapFactory() -> AnimalMapFactoryType
    func makeAnimalDetailFactory() -> AnimalDetailFactoryType
    func makeOrganizationDetailFactory() -> OrganizationDetailFactoryType
}

class SharedFactory: SharedFactoryType {
    
    func makeServiceFactory() -> ServiceFactoryType {
        return ServiceFactory()
    }
    
    func makeHomeFactory() -> HomeFactoryType {
        return HomeFactory(sharedFactory: self)
    }
    
    func makeAnimalFactory() -> AnimalFactoryType {
        return AnimalFactory(sharedFactory: self)
    }
    
    func makeAnimalMapFactory() -> AnimalMapFactoryType {
        return AnimalMapFactory(sharedFactory: self)
    }
    
    func makeOrganizationFactory() -> OrganizationFactoryType {
        return OrganizationFactory(sharedFactory: self)
    }
    
    func makeOnboardingFactory() -> OnboardingFactoryType {
        return OnboardingFactory(sharedFactory: self)
    }
    
    func makeFavoriteFactory() -> FavoriteFactoryType {
        return FavoriteFactory(sharedFactory: self)
    }
    
    func makeAnimalDetailFactory() -> AnimalDetailFactoryType {
        return AnimalDetailFactory(sharedFactory: self)
    }
    
    func makeOrganizationDetailFactory() -> OrganizationDetailFactoryType {
        return OrganizationDetailFactory(sharedFactory: self)
    }
}

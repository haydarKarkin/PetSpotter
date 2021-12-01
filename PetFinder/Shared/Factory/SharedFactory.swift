//
//  SharedFactory.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

protocol SharedFactoryType {
    func makeClientProvider<T: TargetType>(shouldStub: StubType) -> ClientProvider<T>
    func makeHomeFactory() -> HomeFactoryType
    func makeAnimalFactory() -> AnimalFactoryType
    func makeOrganizationFactory() -> OrganizationFactoryType
}

extension SharedFactoryType {
    func makeClientProvider<T: TargetType>(shouldStub: StubType = .never) -> ClientProvider<T> {
        return makeClientProvider(shouldStub: shouldStub)
    }
}

class SharedFactory: SharedFactoryType {
    func makeClientProvider<T: TargetType>(shouldStub: StubType) -> ClientProvider<T> {
        return ClientProvider<T>(shouldStub: shouldStub)
    }
    
    func makeHomeFactory() -> HomeFactoryType {
        return HomeFactory(sharedFactory: self)
    }
    
    func makeAnimalFactory() -> AnimalFactoryType {
        return AnimalFactory(sharedFactory: self)
    }
    
    func makeOrganizationFactory() -> OrganizationFactoryType {
        return OrganizationFactory(sharedFactory: self)
    }
}

//
//  AnimalDetailFactory.swift
//  PetFinder
//
//  Created by hkarkin on 2.02.2022.
//

import Foundation
import UIKit

protocol AnimalDetailFactoryType {
    var  sharedFactory: SharedFactoryType { get }
    func makeAnimalDetailCoordinator(navigationController: UINavigationController, animal: Animal) -> AnimalDetailCoordinatorType
    func makeFavoriteService() -> FavoriteServiceType
    func makeOrganizationService() -> OrganizationServiceType
    func makeAnimalDetailVM(animal: Animal, coordinator: AnimalDetailCoordinatorType) -> AnimalDetailVM
    func makeAnimalDetailVC(animal: Animal, coordinator: AnimalDetailCoordinatorType) -> AnimalDetailVC
}

class AnimalDetailFactory: AnimalDetailFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeAnimalDetailCoordinator(navigationController: UINavigationController, animal: Animal) -> AnimalDetailCoordinatorType {
        AnimalDetailCoordinator(navigationController: navigationController, animalDetailFactory: self, animal: animal)
    }
    
    func makeFavoriteService() -> FavoriteServiceType {
        return FavoriteService()
    }
    
    func makeOrganizationService() -> OrganizationServiceType {
        let clientProvider: ClientProvider<OrganizationAPI> = sharedFactory.makeClientProvider()
        return OrganizationService(provider: clientProvider)
    }
    
    func makeAnimalDetailVM(animal: Animal, coordinator: AnimalDetailCoordinatorType) -> AnimalDetailVM {
        let favoriteService: FavoriteServiceType = makeFavoriteService()
        let organizationService: OrganizationServiceType = makeOrganizationService()
        return AnimalDetailVM(animal: animal,
                              favoriteService: favoriteService,
                              organizationService: organizationService,
                              animalDetailCoordinator: coordinator)
    }
    
    func makeAnimalDetailVC(animal: Animal, coordinator: AnimalDetailCoordinatorType) -> AnimalDetailVC {
        let viewController = AnimalDetailVC.instantiate()
        viewController.viewModel = makeAnimalDetailVM(animal: animal, coordinator: coordinator)
        return viewController
    }
}

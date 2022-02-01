//
//  AnimalDetailFactory.swift
//  PetFinder
//
//  Created by hkarkin on 2.02.2022.
//

import Foundation
import UIKit

protocol AnimalDetailFactoryType {
    func makeAnimalDetailCoordinator(navigationController: UINavigationController, animal: Animal) -> AnimalDetailCoordinatorType
    func makeFavoriteService() -> FavoriteServiceType
    func makeAnimalDetailVM(animal: Animal) -> AnimalDetailVM
    func makeAnimalDetailVC(animal: Animal) -> AnimalDetailVC
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
    
    func makeAnimalDetailVM(animal: Animal) -> AnimalDetailVM {
        let service: FavoriteServiceType = makeFavoriteService()
        return AnimalDetailVM(animal: animal, favoriteService: service)
    }
    
    func makeAnimalDetailVC(animal: Animal) -> AnimalDetailVC {
        let viewController = AnimalDetailVC.instantiate()
        viewController.viewModel = makeAnimalDetailVM(animal: animal)
        return viewController
    }
}

//
//  AnimalMapFactory.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import Foundation
import UIKit

protocol AnimalMapFactoryType {
    func makeAnimalMapCoordinator(navigationController: UINavigationController) -> AnimalMapCoordinatorType
    func makeAnimalService() -> AnimalServiceType
    func makeAnimalMapVM(animalMapCoordinator: AnimalMapCoordinatorType) -> AnimalMapVM
    func makeAnimalMapVC(animalMapCoordinator: AnimalMapCoordinatorType) -> AnimalMapVC
}

class AnimalMapFactory: AnimalMapFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeAnimalMapCoordinator(navigationController: UINavigationController) -> AnimalMapCoordinatorType {
        AnimalMapCoordinator(navigationController: navigationController, animalMapFactory: self)
    }
    
    func makeAnimalService() -> AnimalServiceType {
        sharedFactory.makeAnimalFactory().makeAnimalService()
    }
    
    func makeAnimalMapVM(animalMapCoordinator: AnimalMapCoordinatorType) -> AnimalMapVM {
        let service: AnimalServiceType = makeAnimalService()
        return AnimalMapVM(animalService: service, animalMapCoordinator: animalMapCoordinator)
    }
    
    func makeAnimalMapVC(animalMapCoordinator: AnimalMapCoordinatorType) -> AnimalMapVC {
        let viewController = AnimalMapVC.instantiate()
        viewController.viewModel = makeAnimalMapVM(animalMapCoordinator: animalMapCoordinator)
        return viewController
    }
}

//
//  AnimalMapFactory.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import Foundation
import UIKit

protocol AnimalMapFactoryType {
    var sharedFactory: SharedFactoryType { get }
    func makeAnimalMapCoordinator(navigationController: UINavigationController) -> AnimalMapCoordinatorType
    func makeAnimalMapVM(animalMapCoordinator: AnimalMapCoordinatorType) -> AnimalMapVM
    func makeAnimalMapVC(animalMapCoordinator: AnimalMapCoordinatorType) -> AnimalMapVC
}

class AnimalMapFactory: AnimalMapFactoryType {
    
    let sharedFactory: SharedFactoryType
    let serviceFactory: ServiceFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
        self.serviceFactory = sharedFactory.makeServiceFactory()
    }
    
    func makeAnimalMapCoordinator(navigationController: UINavigationController) -> AnimalMapCoordinatorType {
        AnimalMapCoordinator(navigationController: navigationController, animalMapFactory: self)
    }
    
    func makeAnimalMapVM(animalMapCoordinator: AnimalMapCoordinatorType) -> AnimalMapVM {
        let service: AnimalServiceType = serviceFactory.makeAnimalService()
        return AnimalMapVM(animalService: service, animalMapCoordinator: animalMapCoordinator)
    }
    
    func makeAnimalMapVC(animalMapCoordinator: AnimalMapCoordinatorType) -> AnimalMapVC {
        let viewController = AnimalMapVC.instantiate()
        viewController.viewModel = makeAnimalMapVM(animalMapCoordinator: animalMapCoordinator)
        return viewController
    }
}

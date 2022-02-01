//
//  AnimalFactory.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation
import UIKit

protocol AnimalFactoryType {
    var sharedFactory: SharedFactoryType { get }
    func makeAnimalCoordinator(navigationController: UINavigationController) -> AnimalCoordinatorType
    func makeAnimalService() -> AnimalServiceType
    func makeAnimalsVM(animalService: AnimalServiceType, animalCoordinator: AnimalCoordinatorType) -> AnimalsVM
    func makeAnimalsVC(animalCoordinator: AnimalCoordinatorType) -> AnimalsVC
}

class AnimalFactory: AnimalFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeAnimalCoordinator(navigationController: UINavigationController) -> AnimalCoordinatorType {
        AnimalCoordinator(navigationController: navigationController, animalFactory: self)
    }
    
    func makeAnimalService() -> AnimalServiceType {
        let clientProvider: ClientProvider<AnimalAPI> = sharedFactory.makeClientProvider()
        return AnimalService(provider: clientProvider)
    }
    
    func makeAnimalsVM(animalService: AnimalServiceType, animalCoordinator: AnimalCoordinatorType) -> AnimalsVM {
        AnimalsVM(animalService: animalService, animalCoordinator: animalCoordinator)
    }
    
    func makeAnimalsVC(animalCoordinator: AnimalCoordinatorType) -> AnimalsVC {
        let service: AnimalServiceType = makeAnimalService()
        let viewController = AnimalsVC.instantiate()
        viewController.viewModel = makeAnimalsVM(animalService: service, animalCoordinator: animalCoordinator)
        return viewController
    }
}

//
//  AnimalFactory.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation
import UIKit

protocol AnimalFactoryType {
    func makeAnimalCoordinator(navigationController: UINavigationController) -> AnimalCoordinatorType
    func makeAnimalService() -> AnimalServiceType
    func makeAnimalsVM(animalService: AnimalServiceType) -> AnimalsVM
    func makeAnimalsVC() -> AnimalsVC
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
    
    func makeAnimalsVM(animalService: AnimalServiceType) -> AnimalsVM {
        AnimalsVM(animalService: animalService)
    }
    
    func makeAnimalsVC() -> AnimalsVC {
        let service: AnimalServiceType = makeAnimalService()
        let viewController = AnimalsVC.instantiate()
        viewController.viewModel = makeAnimalsVM(animalService: service)
        return viewController
    }
}

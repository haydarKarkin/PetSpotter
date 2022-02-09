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
    func makeAnimalCoordinator(navigationController: UINavigationController, organizationID: String?) -> AnimalCoordinatorType
    func makeAnimalService() -> AnimalServiceType
    func makeAnimalsVM(animalService: AnimalServiceType, animalCoordinator: AnimalCoordinatorType, organizationID: String?) -> AnimalsVM
    func makeAnimalsVC(animalCoordinator: AnimalCoordinatorType, organizationID: String?) -> AnimalsVC
    func makeAnimalFilterVM(filter: Filter) -> AnimalFilterVM
    func makeAnimalFilterVC(filter: Filter) -> AnimalFilterVC
}

class AnimalFactory: AnimalFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeAnimalCoordinator(navigationController: UINavigationController, organizationID: String?) -> AnimalCoordinatorType {
        AnimalCoordinator(navigationController: navigationController, animalFactory: self, organizationID: organizationID)
    }
    
    func makeAnimalService() -> AnimalServiceType {
        let clientProvider: ClientProvider<AnimalAPI> = sharedFactory.makeClientProvider()
        return AnimalService(provider: clientProvider)
    }
    
    func makeAnimalsVM(animalService: AnimalServiceType,
                       animalCoordinator: AnimalCoordinatorType,
                       organizationID: String?) -> AnimalsVM {
        AnimalsVM(animalService: animalService, animalCoordinator: animalCoordinator, organizationID: organizationID)
    }
    
    func makeAnimalsVC(animalCoordinator: AnimalCoordinatorType,
                       organizationID: String?) -> AnimalsVC {
        let service: AnimalServiceType = makeAnimalService()
        let viewController = AnimalsVC.instantiate()
        viewController.viewModel = makeAnimalsVM(animalService: service, animalCoordinator: animalCoordinator, organizationID: organizationID)
        return viewController
    }
    
    func makeAnimalFilterVM(filter: Filter) -> AnimalFilterVM {
        AnimalFilterVM(filter: filter)
    }
    
    func makeAnimalFilterVC(filter: Filter) -> AnimalFilterVC {
        let viewController = AnimalFilterVC.instantiate()
        viewController.viewModel = makeAnimalFilterVM(filter: filter)
        return viewController
    }
}

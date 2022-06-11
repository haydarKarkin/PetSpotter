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
    func makeAnimalCoordinator(navigationController: UINavigationController, organizationID: String?) -> any Coordinator<AnimalRoute>
    func makeAnimalsVM(animalService: AnimalServiceType, animalCoordinator: any Coordinator<AnimalRoute>, organizationID: String?) -> AnimalsVM
    func makeAnimalsVC(animalCoordinator: any Coordinator<AnimalRoute>, organizationID: String?) -> AnimalsVC
    func makeAnimalFilterVM(filter: Filter) -> AnimalFilterVM
    func makeAnimalFilterVC(filter: Filter) -> AnimalFilterVC
}

class AnimalFactory: AnimalFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
}

extension AnimalFactory {
    
    func makeAnimalCoordinator(navigationController: UINavigationController, organizationID: String?) -> any Coordinator<AnimalRoute> {
        AnimalCoordinator(navigationController: navigationController, animalFactory: self, organizationID: organizationID)
    }
    
    func makeAnimalsVM(animalService: AnimalServiceType,
                       animalCoordinator: any Coordinator<AnimalRoute>,
                       organizationID: String?) -> AnimalsVM {
        AnimalsVM(animalService: animalService, animalCoordinator: animalCoordinator, organizationID: organizationID)
    }
    
    func makeAnimalsVC(animalCoordinator: any Coordinator<AnimalRoute>,
                       organizationID: String?) -> AnimalsVC {
        let animalService = sharedFactory
            .makeServiceFactory()
            .makeAnimalService()
        let viewController = AnimalsVC.instantiate()
        viewController.viewModel = makeAnimalsVM(animalService: animalService, animalCoordinator: animalCoordinator, organizationID: organizationID)
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

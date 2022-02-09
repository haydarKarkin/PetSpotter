//
//  AnimalCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation
import UIKit

protocol AnimalCoordinatorType: Coordinator {
    func showAnimalDetail(animal: Animal)
    func showAnimalFilter(filter: Filter, delegate: AnimalFilterDelegate)
}

class AnimalCoordinator: AnimalCoordinatorType {
    
    private let navigationController: UINavigationController
    private let animalFactory: AnimalFactoryType
    private let organizationID: String?
    
    init(navigationController: UINavigationController,
         animalFactory: AnimalFactoryType,
         organizationID: String? = nil) {
        self.navigationController = navigationController
        self.animalFactory = animalFactory
        self.organizationID = organizationID
    }
    
    func start() {
        let viewController = animalFactory.makeAnimalsVC(animalCoordinator: self, organizationID: organizationID)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showAnimalDetail(animal: Animal) {
        let coordinator = animalFactory
            .sharedFactory
            .makeAnimalDetailFactory()
            .makeAnimalDetailCoordinator(navigationController: navigationController, animal: animal)
        coordinate(to: coordinator)
    }
    
    func showAnimalFilter(filter: Filter, delegate: AnimalFilterDelegate) {
        let viewController = animalFactory.makeAnimalFilterVC(filter: filter)
        viewController.delegate = delegate
        navigationController.present(viewController, animated: true, completion: nil)
    }
}

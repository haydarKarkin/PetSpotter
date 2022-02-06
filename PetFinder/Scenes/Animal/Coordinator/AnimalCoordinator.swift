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
    func showAnimalFilter(animalTypes: [AnimalType])
}

class AnimalCoordinator: AnimalCoordinatorType {
    
    private let navigationController: UINavigationController
    private let animalFactory: AnimalFactoryType
    
    init(navigationController: UINavigationController, animalFactory: AnimalFactoryType) {
        self.navigationController = navigationController
        self.animalFactory = animalFactory
    }
    
    func start() {
        let viewController = animalFactory.makeAnimalsVC(animalCoordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showAnimalDetail(animal: Animal) {
        let coordinator = animalFactory
            .sharedFactory
            .makeAnimalDetailFactory()
            .makeAnimalDetailCoordinator(navigationController: navigationController, animal: animal)
        coordinate(to: coordinator)
    }
    
    func showAnimalFilter(animalTypes: [AnimalType]) {
        let viewController = animalFactory.makeAnimalFilterVC(animalTypes: animalTypes)
        navigationController.present(viewController, animated: true, completion: nil)
    }
}

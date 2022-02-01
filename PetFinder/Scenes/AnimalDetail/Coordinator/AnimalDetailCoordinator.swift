//
//  AnimalDetailCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 2.02.2022.
//

import Foundation
import UIKit

protocol AnimalDetailCoordinatorType: Coordinator {
}

class AnimalDetailCoordinator: AnimalDetailCoordinatorType {
    
    private let navigationController: UINavigationController
    private let animalDetailFactory: AnimalDetailFactoryType
    private let animal: Animal
    
    init(navigationController: UINavigationController,
         animalDetailFactory: AnimalDetailFactoryType,
         animal: Animal) {
        self.navigationController = navigationController
        self.animalDetailFactory = animalDetailFactory
        self.animal = animal
    }
    
    func start() {
        let viewController = animalDetailFactory.makeAnimalDetailVC(animal: animal)
        navigationController.pushViewController(viewController, animated: false)
    }
}

//
//  AnimalCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation
import UIKit

protocol AnimalCoordinatorType: Coordinator {
}

class AnimalCoordinator: AnimalCoordinatorType {
    
    private let navigationController: UINavigationController
    private let animalFactory: AnimalFactoryType
    
    init(navigationController: UINavigationController, animalFactory: AnimalFactoryType) {
        self.navigationController = navigationController
        self.animalFactory = animalFactory
    }
    
    func start() {
        let viewController = animalFactory.makeAnimalsVC()
        navigationController.pushViewController(viewController, animated: false)
    }
}

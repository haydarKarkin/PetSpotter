//
//  AnimalMapCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import Foundation
import UIKit

protocol AnimalMapCoordinatorType: Coordinator {
    func showAnimalDetail()
}

class AnimalMapCoordinator: AnimalMapCoordinatorType {
    
    private let navigationController: UINavigationController
    private let animalMapFactory: AnimalMapFactoryType
    
    init(navigationController: UINavigationController,
         animalMapFactory: AnimalMapFactoryType) {
        self.navigationController = navigationController
        self.animalMapFactory = animalMapFactory
    }
    
    func start() {
        let viewController = animalMapFactory.makeAnimalMapVC(animalMapCoordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showAnimalDetail() {
        
    }
}

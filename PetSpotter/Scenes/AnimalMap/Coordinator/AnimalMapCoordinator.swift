//
//  AnimalMapCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import Foundation
import UIKit

enum AnimalMapRoute: Route {
    case animalMap
    case animalDetail(Animal)
}

class AnimalMapCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let animalMapFactory: AnimalMapFactoryType
    
    init(navigationController: UINavigationController,
         animalMapFactory: AnimalMapFactoryType) {
        self.navigationController = navigationController
        self.animalMapFactory = animalMapFactory
    }
    
    func start() {
        navigate(to: .animalMap)
    }
    
    func navigate(to route: AnimalMapRoute) {
        switch route {
        case .animalMap:
            let viewController = animalMapFactory.makeAnimalMapVC(animalMapCoordinator: self)
            navigationController.pushViewController(viewController, animated: false)
        case .animalDetail(let animal):
            animalMapFactory
                .sharedFactory
                .makeAnimalDetailFactory()
                .makeAnimalDetailCoordinator(navigationController: navigationController, animal: animal)
                .start()
        }
    }
}

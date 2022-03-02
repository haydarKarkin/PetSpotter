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

typealias AnimalMapCoordinatorType = Coordinator<AnimalMapRoute>

class AnimalMapCoordinator: AnimalMapCoordinatorType {
    
    private let animalMapFactory: AnimalMapFactoryType
    
    init(navigationController: UINavigationController,
         animalMapFactory: AnimalMapFactoryType) {
        self.animalMapFactory = animalMapFactory
        super.init(navigationController: navigationController, initialRoute: .animalMap)
    }
    
    override func navigate(to route: AnimalMapRoute) {
        switch route {
        case .animalMap:
            let viewController = animalMapFactory.makeAnimalMapVC(animalMapCoordinator: self)
            navigationController.pushViewController(viewController, animated: false)
        case .animalDetail(let animal):
            let _ = animalMapFactory
                .sharedFactory
                .makeAnimalDetailFactory()
                .makeAnimalDetailCoordinator(navigationController: navigationController, animal: animal)
        }
    }
}

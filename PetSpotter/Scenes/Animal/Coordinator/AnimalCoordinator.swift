//
//  AnimalCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

enum AnimalRoute: Route {
    case animals(String?)
    case animalDetail(Animal)
    case animalFilter(Filter, AnimalFilterDelegate)
}

typealias AnimalCoordinatorType = Coordinator<AnimalRoute>

class AnimalCoordinator: AnimalCoordinatorType {
    
    private let animalFactory: AnimalFactoryType
    
    init(navigationController: UINavigationController, animalFactory: AnimalFactoryType, organizationID: String?) {
        self.animalFactory = animalFactory
        super.init(navigationController: navigationController, initialRoute: .animals(organizationID))
    }
    
    override func navigate(route: AnimalRoute) {
        switch route {
        case .animals(let organizationID):
            let viewController = animalFactory.makeAnimalsVC(animalCoordinator: self, organizationID: organizationID)
            navigationController.pushViewController(viewController, animated: true)
        case .animalDetail(let animal):
            let _ = animalFactory
                .sharedFactory
                .makeAnimalDetailFactory()
                .makeAnimalDetailCoordinator(navigationController: navigationController, animal: animal)
        case .animalFilter(let filter, let delegate):
            let viewController = animalFactory.makeAnimalFilterVC(filter: filter)
            viewController.delegate = delegate
            navigationController.present(viewController, animated: true, completion: nil)
        }
    }
}

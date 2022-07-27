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

class AnimalCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let animalFactory: AnimalFactoryType
    private let organizationID: String?
    
    init(navigationController: UINavigationController, animalFactory: AnimalFactoryType, organizationID: String?) {
        self.navigationController = navigationController
        self.animalFactory = animalFactory
        self.organizationID = organizationID
    }
    
    func start() {
        navigate(to: .animals(organizationID))
    }
    
    func navigate(to route: AnimalRoute) {
        switch route {
        case .animals(let organizationID):
            let viewController = animalFactory.makeAnimalsVC(animalCoordinator: self, organizationID: organizationID)
            navigationController.pushViewController(viewController, animated: true)
        case .animalDetail(let animal):
            animalFactory
                .sharedFactory
                .makeAnimalDetailFactory()
                .makeAnimalDetailCoordinator(navigationController: navigationController, animal: animal)
                .start()
        case .animalFilter(let filter, let delegate):
            let viewController = animalFactory.makeAnimalFilterVC(filter: filter)
            viewController.delegate = delegate
            navigationController.present(viewController, animated: true, completion: nil)
        }
    }
}

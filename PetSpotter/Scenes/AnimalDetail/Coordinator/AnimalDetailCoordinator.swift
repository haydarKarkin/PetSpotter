//
//  AnimalDetailCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 2.02.2022.
//

import Foundation
import UIKit

enum AnimalDetailRoute: Route {
    case animalDetail(Animal)
    case organizationDetail(Organization)
    case videos([Video])
}

class AnimalDetailCoordinator: Coordinator {
    
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
        navigate(to: .animalDetail(animal))
    }
    
    func navigate(to route: AnimalDetailRoute) {
        switch route {
        case .animalDetail(let animal):
            let viewController = animalDetailFactory.makeAnimalDetailVC(animal: animal, coordinator: self)
            navigationController.pushViewController(viewController, animated: true)
        case .organizationDetail(let organization):
            animalDetailFactory
                .sharedFactory
                .makeOrganizationDetailFactory()
                .makeOrganizationDetailCoordinator(navigationController: navigationController, organization: organization)
                .start()
        case .videos(let videos):
            let viewController = animalDetailFactory.makeVideosVC(videos: videos)
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}

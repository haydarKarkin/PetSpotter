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

typealias AnimalDetailCoordinatorType = Coordinator<AnimalDetailRoute>

class AnimalDetailCoordinator: AnimalDetailCoordinatorType {
    
    private let animalDetailFactory: AnimalDetailFactoryType
    
    init(navigationController: UINavigationController,
         animalDetailFactory: AnimalDetailFactoryType,
         animal: Animal) {
        self.animalDetailFactory = animalDetailFactory
        super.init(navigationController: navigationController, initialRoute: .animalDetail(animal))
    }
    
    override func navigate(to route: AnimalDetailRoute) {
        switch route {
        case .animalDetail(let animal):
            let viewController = animalDetailFactory.makeAnimalDetailVC(animal: animal, coordinator: self)
            navigationController.pushViewController(viewController, animated: true)
        case .organizationDetail(let organization):
            let _ = animalDetailFactory
                .sharedFactory
                .makeOrganizationDetailFactory()
                .makeOrganizationDetailCoordinator(navigationController: navigationController, organization: organization)
        case .videos(let videos):
            let viewController = animalDetailFactory.makeVideosVC(videos: videos)
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}

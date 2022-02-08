//
//  AnimalDetailCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 2.02.2022.
//

import Foundation
import UIKit

protocol AnimalDetailCoordinatorType: Coordinator {
    func showOrganizationDetail(with organization: Organization)
    func showVideos(with videos: [Video])
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
        let viewController = animalDetailFactory.makeAnimalDetailVC(animal: animal, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showOrganizationDetail(with organization: Organization) {
        let coordinator = animalDetailFactory
            .sharedFactory
            .makeOrganizationDetailFactory()
            .makeOrganizationDetailCoordinator(navigationController: navigationController, organization: organization)
        coordinate(to: coordinator)
    }
    
    func showVideos(with videos: [Video]) {
        let viewController = animalDetailFactory.makeVideosVC(videos: videos)
        navigationController.pushViewController(viewController, animated: true)
    }
}

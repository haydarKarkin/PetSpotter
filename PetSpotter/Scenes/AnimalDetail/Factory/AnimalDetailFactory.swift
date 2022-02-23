//
//  AnimalDetailFactory.swift
//  PetFinder
//
//  Created by hkarkin on 2.02.2022.
//

import Foundation
import UIKit

protocol AnimalDetailFactoryType {
    var sharedFactory: SharedFactoryType { get }
    var serviceFactory: ServiceFactoryType { get }
    func makeAnimalDetailCoordinator(navigationController: UINavigationController, animal: Animal) -> AnimalDetailCoordinatorType
    func makeAnimalDetailVM(animal: Animal, coordinator: AnimalDetailCoordinatorType) -> AnimalDetailVM
    func makeAnimalDetailVC(animal: Animal, coordinator: AnimalDetailCoordinatorType) -> AnimalDetailVC
    func makeVideosVM(videos: [Video]) -> VideosVM
    func makeVideosVC(videos: [Video]) -> VideosVC 
}

class AnimalDetailFactory: AnimalDetailFactoryType {
    
    let sharedFactory: SharedFactoryType
    let serviceFactory: ServiceFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
        self.serviceFactory = sharedFactory.makeServiceFactory()
    }
}

extension AnimalDetailFactory {
    
    func makeAnimalDetailCoordinator(navigationController: UINavigationController, animal: Animal) -> AnimalDetailCoordinatorType {
        AnimalDetailCoordinator(navigationController: navigationController, animalDetailFactory: self, animal: animal)
    }
    
    
    func makeAnimalDetailVM(animal: Animal, coordinator: AnimalDetailCoordinatorType) -> AnimalDetailVM {
        let favoriteService: FavoriteServiceType = serviceFactory.makeFavoriteService()
        let organizationService: OrganizationServiceType = serviceFactory.makeOrganizationService()
        return AnimalDetailVM(animal: animal,
                              favoriteService: favoriteService,
                              organizationService: organizationService,
                              animalDetailCoordinator: coordinator)
    }
    
    func makeAnimalDetailVC(animal: Animal, coordinator: AnimalDetailCoordinatorType) -> AnimalDetailVC {
        let viewController = AnimalDetailVC.instantiate()
        viewController.viewModel = makeAnimalDetailVM(animal: animal, coordinator: coordinator)
        return viewController
    }
    
    func makeVideosVM(videos: [Video]) -> VideosVM {
        VideosVM(videos: videos)
    }
    
    func makeVideosVC(videos: [Video]) -> VideosVC {
        let viewController = VideosVC.instantiate()
        viewController.viewModel = makeVideosVM(videos: videos)
        return viewController
    }
}

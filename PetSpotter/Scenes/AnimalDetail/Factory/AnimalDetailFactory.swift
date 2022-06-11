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
    func makeAnimalDetailCoordinator(navigationController: UINavigationController, animal: Animal) -> any Coordinator<AnimalDetailRoute>
    func makeAnimalDetailVM(animal: Animal, coordinator: any Coordinator<AnimalDetailRoute>) -> AnimalDetailVM
    func makeAnimalDetailVC(animal: Animal, coordinator: any Coordinator<AnimalDetailRoute>) -> AnimalDetailVC
    func makeVideosVM(videos: [Video]) -> VideosVM
    func makeVideosVC(videos: [Video]) -> VideosVC 
}

class AnimalDetailFactory: AnimalDetailFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
}

extension AnimalDetailFactory {
    
    func makeAnimalDetailCoordinator(navigationController: UINavigationController, animal: Animal) -> any Coordinator<AnimalDetailRoute> {
        AnimalDetailCoordinator(navigationController: navigationController, animalDetailFactory: self, animal: animal)
    }
    
    
    func makeAnimalDetailVM(animal: Animal, coordinator: any Coordinator<AnimalDetailRoute>) -> AnimalDetailVM {
        let favoriteService = sharedFactory
            .makeServiceFactory()
            .makeFavoriteService()
        let organizationService = sharedFactory
            .makeServiceFactory()
            .makeOrganizationService()
        return AnimalDetailVM(animal: animal,
                              favoriteService: favoriteService,
                              organizationService: organizationService,
                              animalDetailCoordinator: coordinator)
    }
    
    func makeAnimalDetailVC(animal: Animal, coordinator: any Coordinator<AnimalDetailRoute>) -> AnimalDetailVC {
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

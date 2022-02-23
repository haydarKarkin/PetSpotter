//
//  FavoriteFactory.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import Foundation
import UIKit

protocol FavoriteFactoryType {
    var sharedFactory: SharedFactoryType { get }
    func makeFavoriteCoordinator(navigationController: UINavigationController) -> FavoriteCoordinatorType
    func makeFavoritesVM(favoriteCoordinator: FavoriteCoordinatorType) -> FavoritesVM
    func makeFavoritesVC(favoriteCoordinator: FavoriteCoordinatorType) -> FavoritesVC 
}

class FavoriteFactory: FavoriteFactoryType {
    
    let sharedFactory: SharedFactoryType
    let serviceFactory: ServiceFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
        self.serviceFactory = sharedFactory.makeServiceFactory()
    }
    
    func makeFavoriteCoordinator(navigationController: UINavigationController) -> FavoriteCoordinatorType {
        FavoriteCoordinator(navigationController: navigationController, favoriteFactory: self)
    }
    
    func makeFavoritesVM(favoriteCoordinator: FavoriteCoordinatorType) -> FavoritesVM {
        let favoriteService: FavoriteServiceType = serviceFactory.makeFavoriteService()
        let animalService: AnimalServiceType = serviceFactory.makeAnimalService()
        return FavoritesVM(favoriteService: favoriteService,
                           favoriteCoordinator: favoriteCoordinator,
                           animalService: animalService)
    }
    
    func makeFavoritesVC(favoriteCoordinator: FavoriteCoordinatorType) -> FavoritesVC {
        let viewController = FavoritesVC.instantiate()
        viewController.viewModel = makeFavoritesVM(favoriteCoordinator: favoriteCoordinator)
        return viewController
    }
}

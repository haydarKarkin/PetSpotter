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
    func makeFavoriteCoordinator(navigationController: UINavigationController) -> any Coordinator<FavoriteRoute>
    func makeFavoritesVM(favoriteCoordinator: any Coordinator<FavoriteRoute>) -> FavoritesVM
    func makeFavoritesVC(favoriteCoordinator: any Coordinator<FavoriteRoute>) -> FavoritesVC
}

class FavoriteFactory: FavoriteFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
}

extension FavoriteFactory {
    
    func makeFavoriteCoordinator(navigationController: UINavigationController) -> any Coordinator<FavoriteRoute> {
        FavoriteCoordinator(navigationController: navigationController, favoriteFactory: self)
    }
    
    func makeFavoritesVM(favoriteCoordinator: any Coordinator<FavoriteRoute>) -> FavoritesVM {
        let favoriteService = sharedFactory
            .makeServiceFactory()
            .makeFavoriteService()
        let animalService = sharedFactory
            .makeServiceFactory()
            .makeAnimalService()
        return FavoritesVM(favoriteService: favoriteService,
                           favoriteCoordinator: favoriteCoordinator,
                           animalService: animalService)
    }
    
    func makeFavoritesVC(favoriteCoordinator: any Coordinator<FavoriteRoute>) -> FavoritesVC {
        let viewController = FavoritesVC.instantiate()
        viewController.viewModel = makeFavoritesVM(favoriteCoordinator: favoriteCoordinator)
        return viewController
    }
}

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
    func makeFavoriteService() -> FavoriteServiceType
    func makeFavoritesVM(favoriteCoordinator: FavoriteCoordinatorType) -> FavoritesVM
    func makeFavoritesVC(favoriteCoordinator: FavoriteCoordinatorType) -> FavoritesVC 
}

class FavoriteFactory: FavoriteFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeFavoriteCoordinator(navigationController: UINavigationController) -> FavoriteCoordinatorType {
        FavoriteCoordinator(navigationController: navigationController, favoriteFactory: self)
    }
    
    func makeFavoriteService() -> FavoriteServiceType {
        return FavoriteService()
    }
    
    func makeFavoritesVM(favoriteCoordinator: FavoriteCoordinatorType) -> FavoritesVM {
        let service: FavoriteServiceType = makeFavoriteService()
        return FavoritesVM(favoriteService: service, favoriteCoordinator: favoriteCoordinator)
    }
    
    func makeFavoritesVC(favoriteCoordinator: FavoriteCoordinatorType) -> FavoritesVC {
        let viewController = FavoritesVC.instantiate()
        viewController.viewModel = makeFavoritesVM(favoriteCoordinator: favoriteCoordinator)
        return viewController
    }
}

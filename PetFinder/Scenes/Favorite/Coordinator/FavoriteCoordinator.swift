//
//  FavoriteCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import Foundation
import UIKit

protocol FavoriteCoordinatorType: Coordinator {
    func showAnimalDetail()
}

class FavoriteCoordinator: FavoriteCoordinatorType {
    
    private let navigationController: UINavigationController
    private let favoriteFactory: FavoriteFactoryType
    
    init(navigationController: UINavigationController,
         favoriteFactory: FavoriteFactoryType) {
        self.navigationController = navigationController
        self.favoriteFactory = favoriteFactory
    }
    
    func start() {
        let viewController = favoriteFactory.makeFavoritesVC(favoriteCoordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showAnimalDetail() {
        
    }
}

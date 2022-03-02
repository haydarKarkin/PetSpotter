//
//  FavoriteCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import Foundation
import UIKit

enum FavoriteRoute: Route {
    case favorite
    case animalDetail(Animal)
}

typealias FavoriteCoordinatorType = Coordinator<FavoriteRoute>

class FavoriteCoordinator: FavoriteCoordinatorType {
    
    private let favoriteFactory: FavoriteFactoryType
    
    init(navigationController: UINavigationController,
         favoriteFactory: FavoriteFactoryType) {
        self.favoriteFactory = favoriteFactory
        super.init(navigationController: navigationController, initialRoute: .favorite)
    }
    
    override func navigate(route: FavoriteRoute) {
        switch route {
        case .favorite:
            let viewController = favoriteFactory.makeFavoritesVC(favoriteCoordinator: self)
            navigationController.pushViewController(viewController, animated: false)
        case .animalDetail(let animal):
            let _ = favoriteFactory
                .sharedFactory
                .makeAnimalDetailFactory()
                .makeAnimalDetailCoordinator(navigationController: navigationController, animal: animal)
        }
    }
}

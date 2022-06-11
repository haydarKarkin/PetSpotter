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

class FavoriteCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let favoriteFactory: FavoriteFactoryType
    
    init(navigationController: UINavigationController,
         favoriteFactory: FavoriteFactoryType) {
        self.navigationController = navigationController
        self.favoriteFactory = favoriteFactory
    }
    
    func start() {
        navigate(to: .favorite)
    }
    
    func navigate(to route: FavoriteRoute) {
        switch route {
        case .favorite:
            let viewController = favoriteFactory.makeFavoritesVC(favoriteCoordinator: self)
            navigationController.pushViewController(viewController, animated: false)
        case .animalDetail(let animal):
            favoriteFactory
                .sharedFactory
                .makeAnimalDetailFactory()
                .makeAnimalDetailCoordinator(navigationController: navigationController, animal: animal)
                .start()
        }
    }
}

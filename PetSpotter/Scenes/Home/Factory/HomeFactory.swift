//
//  HomeFactory.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import Foundation
import UIKit

protocol HomeFactoryType {
    func makeHomeCoordinator(navigationController: UINavigationController, route: HomeRoute) -> HomeCoordinatorType
    func makeHomeVC() -> HomeVC
}

class HomeFactory: HomeFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeHomeCoordinator(navigationController: UINavigationController, route: HomeRoute) -> HomeCoordinatorType {
        HomeCoordinator(navigationController: navigationController,
                        sharedFactory: sharedFactory,
                        route: route)
    }
    
    func makeHomeVC() -> HomeVC {
        HomeVC()
    }
}

//
//  HomeFactory.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import Foundation
import UIKit

protocol HomeFactoryType {
    func makeHomeCoordinator(navigationController: UINavigationController) -> HomeCoordinatorType
    func makeHomeVC() -> HomeVC
}

class HomeFactory: HomeFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeHomeCoordinator(navigationController: UINavigationController) -> HomeCoordinatorType {
        HomeCoordinator(navigationController: navigationController, homeFactory: self, sharedFactory: sharedFactory)
    }
    
    func makeHomeVC() -> HomeVC {
        HomeVC()
    }
}

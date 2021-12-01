//
//  HomeCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import UIKit

protocol HomeCoordinatorType: Coordinator {
}

class HomeCoordinator: HomeCoordinatorType {
    
    private let navigationController: UINavigationController
    private let homeFactory: HomeFactoryType
    private let sharedFactory: SharedFactoryType
    
    init(navigationController: UINavigationController, homeFactory: HomeFactoryType, sharedFactory: SharedFactoryType) {
        self.navigationController = navigationController
        self.homeFactory = homeFactory
        self.sharedFactory = sharedFactory
    }
    
    func start() {
        let homeVC = homeFactory.makeHomeVC()
        homeVC.coordinator = self
        
        let animalNavigationController = UINavigationController()
        animalNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        let animalCoordinator = sharedFactory
            .makeAnimalFactory()
            .makeAnimalCoordinator(navigationController: animalNavigationController)
        
        homeVC.viewControllers = [animalNavigationController]
        homeVC.modalPresentationStyle = .fullScreen
        navigationController.present(homeVC, animated: true, completion: nil)
        
        coordinate(to: animalCoordinator)
    }
}

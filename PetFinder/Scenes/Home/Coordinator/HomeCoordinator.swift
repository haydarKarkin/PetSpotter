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
        
        let animalNC = UINavigationController()
        animalNC.tabBarItem = UITabBarItem(title: "Animals", image: .actions, tag: 0)
        let animalCoordinator = sharedFactory
            .makeAnimalFactory()
            .makeAnimalCoordinator(navigationController: animalNC)
        
        let organizationNC = UINavigationController()
        organizationNC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        let organizationCoordinator = sharedFactory
            .makeOrganizationFactory()
            .makeOrganizationCoordinator(navigationController: organizationNC)
        
        homeVC.viewControllers = [animalNC, organizationNC]
        homeVC.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.present(homeVC, animated: true, completion: nil)
        }
        coordinate(to: animalCoordinator)
        coordinate(to: organizationCoordinator)
    }
}

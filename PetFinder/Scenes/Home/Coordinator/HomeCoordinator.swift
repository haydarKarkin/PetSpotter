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
        
        UITabBar.appearance().tintColor = UIColor(named: "PrimaryRed")
        
        let animalNC = UINavigationController()
        animalNC.tabBarItem = UITabBarItem(title: "Animals", image: UIImage(systemName: "pawprint"), tag: 0)
        let animalCoordinator = sharedFactory
            .makeAnimalFactory()
            .makeAnimalCoordinator(navigationController: animalNC)
        
        let animalMapNC = UINavigationController()
        animalMapNC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 1)
        let animalMapCoordinator = sharedFactory
            .makeAnimalMapFactory()
            .makeAnimalMapCoordinator(navigationController: animalMapNC)
        
        let favoriteNC = UINavigationController()
        favoriteNC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 2)
        let favoriteCoordinator = sharedFactory
            .makeFavoriteFactory()
            .makeFavoriteCoordinator(navigationController: favoriteNC)
        
        let organizationNC = UINavigationController()
        organizationNC.tabBarItem = UITabBarItem(title: "Organizations", image: UIImage(systemName: "house"), tag: 3)
        let organizationCoordinator = sharedFactory
            .makeOrganizationFactory()
            .makeOrganizationCoordinator(navigationController: organizationNC)
        
        homeVC.viewControllers = [animalNC, animalMapNC, favoriteNC, organizationNC]
        homeVC.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.present(homeVC, animated: true, completion: nil)
        }
        coordinate(to: animalCoordinator)
        coordinate(to: animalMapCoordinator)
        coordinate(to: organizationCoordinator)
        coordinate(to: favoriteCoordinator)
    }
}

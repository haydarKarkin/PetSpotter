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
    private let route: HomeRoute
    
    init(navigationController: UINavigationController,
         homeFactory: HomeFactoryType,
         sharedFactory: SharedFactoryType,
         route: HomeRoute = .animals) {
        self.navigationController = navigationController
        self.homeFactory = homeFactory
        self.sharedFactory = sharedFactory
        self.route = route
    }
    
    func start() {
        let homeVC = homeFactory.makeHomeVC()
        homeVC.coordinator = self
        
        let animalNC = UINavigationController()
        animalNC.tabBarItem = UITabBarItem(title: "Animals", image: UIImage(systemName: "pawprint"), tag: 0)
        let animalCoordinator = sharedFactory
            .makeAnimalFactory()
            .makeAnimalCoordinator(navigationController: animalNC, organizationID: nil)
        
        let favoriteNC = UINavigationController()
        favoriteNC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        let favoriteCoordinator = sharedFactory
            .makeFavoriteFactory()
            .makeFavoriteCoordinator(navigationController: favoriteNC)
        
        let organizationNC = UINavigationController()
        organizationNC.tabBarItem = UITabBarItem(title: "Organizations", image: UIImage(systemName: "house"), tag: 2)
        let organizationCoordinator = sharedFactory
            .makeOrganizationFactory()
            .makeOrganizationCoordinator(navigationController: organizationNC)
        
        homeVC.viewControllers = [animalNC, favoriteNC, organizationNC]
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.selectedIndex = route.rawValue
        
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.present(homeVC, animated: true, completion: nil)
        }
        coordinate(to: animalCoordinator)
        coordinate(to: organizationCoordinator)
        coordinate(to: favoriteCoordinator)
    }
}

extension HomeCoordinator {
    
    enum HomeRoute: Int {
        case animals
        case favorites
        case organizations
    }
}

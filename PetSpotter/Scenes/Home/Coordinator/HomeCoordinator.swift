//
//  HomeCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import UIKit

enum HomeRoute: Int, Route {
    case animals
    case favorites
    case organizations
}

class HomeCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let sharedFactory: SharedFactoryType
    private let homeVC: HomeVC
    private let route: HomeRoute
    
    init(navigationController: UINavigationController,
         sharedFactory: SharedFactoryType,
         route: HomeRoute = .animals) {
        self.navigationController = navigationController
        self.sharedFactory = sharedFactory
        self.homeVC = sharedFactory
            .makeHomeFactory()
            .makeHomeVC()
        self.route = route
        
        let animalNC = UINavigationController()
        animalNC.tabBarItem = UITabBarItem(title: "Animals", image: UIImage(systemName: "pawprint"), tag: 0)
        sharedFactory
            .makeAnimalFactory()
            .makeAnimalCoordinator(navigationController: animalNC, organizationID: nil)
            .start()
        
        let favoriteNC = UINavigationController()
        favoriteNC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        sharedFactory
            .makeFavoriteFactory()
            .makeFavoriteCoordinator(navigationController: favoriteNC)
            .start()
        
        let organizationNC = UINavigationController()
        organizationNC.tabBarItem = UITabBarItem(title: "Organizations", image: UIImage(systemName: "house"), tag: 2)
        sharedFactory
            .makeOrganizationFactory()
            .makeOrganizationCoordinator(navigationController: organizationNC)
            .start()
        
        homeVC.viewControllers = [
            animalNC,
            favoriteNC,
            organizationNC
        ]
    }
    
    func start() {
        navigate(to: route)
    }
    
    func navigate(to route: HomeRoute) {
        guard let homeVC = navigationController.topViewController as? HomeVC else {
            self.homeVC.coordinator = self
            self.homeVC.modalPresentationStyle = .fullScreen
            self.homeVC.selectedIndex = route.rawValue
            self.navigationController.present(self.homeVC, animated: true, completion: nil)
            return
        }
        homeVC.selectedIndex = route.rawValue
    }
}

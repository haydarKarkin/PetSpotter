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

typealias HomeCoordinatorType = Coordinator<HomeRoute>

class HomeCoordinator: HomeCoordinatorType {
    
    private let sharedFactory: SharedFactoryType
    private let homeVC: HomeVC
    
    init(navigationController: UINavigationController,
         sharedFactory: SharedFactoryType,
         route: HomeRoute = .animals) {
        self.sharedFactory = sharedFactory
        self.homeVC = sharedFactory
            .makeHomeFactory()
            .makeHomeVC()
        
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
        
        homeVC.viewControllers = [
            animalCoordinator.navigationController,
            favoriteCoordinator.navigationController,
            organizationCoordinator.navigationController
        ]
    
        super.init(navigationController: navigationController, initialRoute: route)
    }
    
    override func navigate(to route: HomeRoute) {
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

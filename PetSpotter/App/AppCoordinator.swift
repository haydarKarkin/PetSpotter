//
//  AppCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

protocol AppCoordinatorType: Coordinator {
    func showHome(route: HomeCoordinator.HomeRoute)
    func showOnboarding()
}

class AppCoordinator: AppCoordinatorType {
    
    private let sharedFactory: SharedFactoryType
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, sharedFactory: SharedFactoryType) {
        self.navigationController = navigationController
        self.sharedFactory = sharedFactory
    }
    
    func start() {
        showOnboarding()
    }
    
    func showOnboarding() {
        let onboardingCoordinator = sharedFactory
            .makeOnboardingFactory()
            .makeOnboardingCoordinator(navigationController: navigationController, delegate: self)
        coordinate(to: onboardingCoordinator)
    }
    
    func showHome(route: HomeCoordinator.HomeRoute = .animals) {
        let homeCoordinator = sharedFactory
            .makeHomeFactory()
            .makeHomeCoordinator(navigationController: navigationController, route: route)
        coordinate(to: homeCoordinator)
    }
}

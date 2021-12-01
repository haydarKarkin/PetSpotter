//
//  AppCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

protocol AppCoordinatorType: Coordinator {
    func showHome()
}

class AppCoordinator: AppCoordinatorType {
    
    private let window: UIWindow
    private let sharedFactory: SharedFactoryType
    
    init(window: UIWindow, sharedFactory: SharedFactoryType) {
        self.window = window
        self.sharedFactory = sharedFactory
    }
    
    func start() {
        let navigationController = UINavigationController()
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        
        let onboardingCoordinator = sharedFactory
            .makeOnboardingFactory()
            .makeOnboardingCoordinator(navigationController: navigationController, delegate: self)
        
        coordinate(to: onboardingCoordinator)
    }
    
    func showHome() {
        let navigationController = UINavigationController()
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        
        let homeCoordinator = sharedFactory
            .makeHomeFactory()
            .makeHomeCoordinator(navigationController: navigationController)
        
        coordinate(to: homeCoordinator)
    }
}

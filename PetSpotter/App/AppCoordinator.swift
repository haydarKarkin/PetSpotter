//
//  AppCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

enum AppRoute: Route {
    case onboarding
    case home(HomeRoute)
}

class AppCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    private let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.navigationController = UINavigationController()
        self.sharedFactory = sharedFactory
    }
    
    func start() {
        navigate(to: .onboarding)
    }
    
    func navigate(to route: AppRoute) {
        switch route {
        case .onboarding:
            sharedFactory
                .makeOnboardingFactory()
                .makeOnboardingCoordinator(navigationController: navigationController, appCoordinator: self)
                .start()
        case .home(let homeRoute):
            sharedFactory
                .makeHomeFactory()
                .makeHomeCoordinator(navigationController: navigationController, route: homeRoute)
                .start()
        }
    }
}

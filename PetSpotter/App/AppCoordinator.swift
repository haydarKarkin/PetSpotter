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

typealias AppCoordinatorType = Coordinator<AppRoute>

class AppCoordinator: AppCoordinatorType {
    
    private let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
        super.init(navigationController: UINavigationController(), initialRoute: .onboarding)
    }
    
    override func navigate(route: AppRoute) {
        switch route {
        case .onboarding:
            let _ = sharedFactory
                .makeOnboardingFactory()
                .makeOnboardingCoordinator(navigationController: navigationController, appCoordinator: self)
        case .home(let homeRoute):
            let _ = sharedFactory
                .makeHomeFactory()
                .makeHomeCoordinator(navigationController: navigationController, route: homeRoute)
        }
    }
}

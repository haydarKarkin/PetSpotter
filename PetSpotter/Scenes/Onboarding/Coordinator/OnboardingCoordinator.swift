//
//  OnboardingCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import Foundation
import UIKit

enum OnboardingRoute: Route {
    case onboarding
    case home(HomeRoute)
}

class OnboardingCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let onboardingFactory: OnboardingFactoryType
    private let appCoordinator: any Coordinator<AppRoute>
    
    init(navigationController: UINavigationController,
         onboardingFactory: OnboardingFactoryType,
         appCoordinator: any Coordinator<AppRoute>) {
        self.navigationController = navigationController
        self.onboardingFactory = onboardingFactory
        self.appCoordinator = appCoordinator
    }
    
    func start() {
        navigate(to: .onboarding)
    }
    
    func navigate(to route: OnboardingRoute) {
        switch route {
        case .onboarding:
            let viewController = onboardingFactory.makeOnboardingVC(onboardingCoordinator: self)
            navigationController.pushViewController(viewController, animated: false)
        case .home(let homeRoute):
            appCoordinator.navigate(to: .home(homeRoute))
        }
    }
}

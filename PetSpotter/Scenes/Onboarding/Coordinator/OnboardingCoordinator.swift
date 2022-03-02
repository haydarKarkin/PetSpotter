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

typealias OnboardingCoordinatorType = Coordinator<OnboardingRoute>

class OnboardingCoordinator: OnboardingCoordinatorType {
    
    private let onboardingFactory: OnboardingFactoryType
    private weak var appCoordinator: AppCoordinatorType?
    
    init(navigationController: UINavigationController,
         onboardingFactory: OnboardingFactoryType,
         appCoordinator: AppCoordinatorType) {
        self.onboardingFactory = onboardingFactory
        self.appCoordinator = appCoordinator
        super.init(navigationController: navigationController, initialRoute: .onboarding)
    }
    
    override func navigate(to route: OnboardingRoute) {
        switch route {
        case .onboarding:
            let viewController = onboardingFactory.makeOnboardingVC(onboardingCoordinator: self)
            navigationController.pushViewController(viewController, animated: false)
        case .home(let homeRoute):
            appCoordinator?.navigate(to: .home(homeRoute))
        }
    }
}

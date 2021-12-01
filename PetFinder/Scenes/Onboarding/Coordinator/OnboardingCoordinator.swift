//
//  OnboardingCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import Foundation
import UIKit

protocol OnboardingCoordinatorType: Coordinator {
}

class OnboardingCoordinator: OnboardingCoordinatorType {
    
    private let navigationController: UINavigationController
    private let onboardingFactory: OnboardingFactoryType
    
    init(navigationController: UINavigationController, onboardingFactory: OnboardingFactoryType) {
        self.navigationController = navigationController
        self.onboardingFactory = onboardingFactory
    }
    
    func start() {
        let viewController = onboardingFactory.makeOnboardingVC()
        navigationController.pushViewController(viewController, animated: false)
    }
}

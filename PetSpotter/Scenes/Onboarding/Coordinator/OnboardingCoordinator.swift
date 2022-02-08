//
//  OnboardingCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import Foundation
import UIKit

protocol OnboardingCoordinatorType: Coordinator {
    func showHome()
}

class OnboardingCoordinator: OnboardingCoordinatorType {
    
    private let navigationController: UINavigationController
    private let onboardingFactory: OnboardingFactoryType
    private weak var delegate: AppCoordinatorType?
    
    init(navigationController: UINavigationController,
         onboardingFactory: OnboardingFactoryType,
         delegate: AppCoordinatorType) {
        self.navigationController = navigationController
        self.onboardingFactory = onboardingFactory
        self.delegate = delegate
    }
    
    func start() {
        let viewController = onboardingFactory.makeOnboardingVC(onboardingCoordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showHome() {
        delegate?.showHome()
    }
}

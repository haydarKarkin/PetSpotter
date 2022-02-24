//
//  OnboardingFactory.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import Foundation
import UIKit

protocol OnboardingFactoryType {
    var sharedFactory: SharedFactoryType { get }
    func makeOnboardingCoordinator(navigationController: UINavigationController, delegate: AppCoordinatorType) -> OnboardingCoordinatorType
    func makeOnboardingVM(onboardingCoordinator: OnboardingCoordinatorType) -> OnboardingVM
    func makeOnboardingVC(onboardingCoordinator: OnboardingCoordinatorType) -> OnboardingVC
}

class OnboardingFactory: OnboardingFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
}

extension OnboardingFactory {
    
    func makeOnboardingCoordinator(navigationController: UINavigationController, delegate: AppCoordinatorType) -> OnboardingCoordinatorType {
        OnboardingCoordinator(navigationController: navigationController, onboardingFactory: self, delegate: delegate)
    }
    
    func makeOnboardingVM(onboardingCoordinator: OnboardingCoordinatorType) -> OnboardingVM {
        let onboardingService = sharedFactory
            .makeServiceFactory()
            .makeOnboardingService()
        return OnboardingVM(onboardingService: onboardingService, onboardingCoordinator: onboardingCoordinator)
    }
    
    func makeOnboardingVC(onboardingCoordinator: OnboardingCoordinatorType) -> OnboardingVC {
        let viewController = OnboardingVC.instantiate()
        viewController.viewModel = makeOnboardingVM(onboardingCoordinator: onboardingCoordinator)
        return viewController
    }
}

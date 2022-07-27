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
    func makeOnboardingCoordinator(navigationController: UINavigationController, appCoordinator: any Coordinator<AppRoute>) -> any Coordinator<OnboardingRoute>
    func makeOnboardingVM(onboardingCoordinator: any Coordinator<OnboardingRoute>) -> OnboardingVM
    func makeOnboardingVC(onboardingCoordinator: any Coordinator<OnboardingRoute>) -> OnboardingVC
}

class OnboardingFactory: OnboardingFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
}

extension OnboardingFactory {
    
    func makeOnboardingCoordinator(navigationController: UINavigationController,
                                   appCoordinator: any Coordinator<AppRoute>) -> any Coordinator<OnboardingRoute> {
        OnboardingCoordinator(navigationController: navigationController, onboardingFactory: self, appCoordinator: appCoordinator)
    }
    
    func makeOnboardingVM(onboardingCoordinator: any Coordinator<OnboardingRoute>) -> OnboardingVM {
        let onboardingService = sharedFactory
            .makeServiceFactory()
            .makeOnboardingService()
        return OnboardingVM(onboardingService: onboardingService, onboardingCoordinator: onboardingCoordinator)
    }
    
    func makeOnboardingVC(onboardingCoordinator: any Coordinator<OnboardingRoute>) -> OnboardingVC {
        let viewController = OnboardingVC.instantiate()
        viewController.viewModel = makeOnboardingVM(onboardingCoordinator: onboardingCoordinator)
        return viewController
    }
}

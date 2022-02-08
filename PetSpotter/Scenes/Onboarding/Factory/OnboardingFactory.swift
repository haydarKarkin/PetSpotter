//
//  OnboardingFactory.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import Foundation
import UIKit

protocol OnboardingFactoryType {
    func makeOnboardingCoordinator(navigationController: UINavigationController, delegate: AppCoordinatorType) -> OnboardingCoordinatorType
    func makeOnboardingService() -> OnboardingServiceType
    func makeOnboardingVM(onboardingCoordinator: OnboardingCoordinatorType) -> OnboardingVM
    func makeOnboardingVC(onboardingCoordinator: OnboardingCoordinatorType) -> OnboardingVC
}

class OnboardingFactory: OnboardingFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeOnboardingCoordinator(navigationController: UINavigationController, delegate: AppCoordinatorType) -> OnboardingCoordinatorType {
        OnboardingCoordinator(navigationController: navigationController, onboardingFactory: self, delegate: delegate)
    }
    
    func makeOnboardingService() -> OnboardingServiceType {
        let clientProvider: ClientProvider<OnboardingAPI> = sharedFactory.makeClientProvider()
        return OnboardingService(provider: clientProvider)
    }
    
    func makeOnboardingVM(onboardingCoordinator: OnboardingCoordinatorType) -> OnboardingVM {
        let service: OnboardingServiceType = makeOnboardingService()
        return OnboardingVM(onboardingService: service, onboardingCoordinator: onboardingCoordinator)
    }
    
    func makeOnboardingVC(onboardingCoordinator: OnboardingCoordinatorType) -> OnboardingVC {
        let viewController = OnboardingVC.instantiate()
        viewController.viewModel = makeOnboardingVM(onboardingCoordinator: onboardingCoordinator)
        return viewController
    }
}

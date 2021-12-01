//
//  OnboardingFactory.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import Foundation
import UIKit

protocol OnboardingFactoryType {
    func makeOnboardingCoordinator(navigationController: UINavigationController) -> OnboardingCoordinatorType
    func makeOnboardingService() -> OnboardingServiceType
    func makeOnboardingVM(onboardingService: OnboardingServiceType) -> OnboardingVM
    func makeOnboardingVC() -> OnboardingVC
}

class OnboardingFactory: OnboardingFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeOnboardingCoordinator(navigationController: UINavigationController) -> OnboardingCoordinatorType {
        OnboardingCoordinator(navigationController: navigationController, onboardingFactory: self)
    }
    
    func makeOnboardingService() -> OnboardingServiceType {
        let clientProvider: ClientProvider<OnboardingAPI> = sharedFactory.makeClientProvider()
        return OnboardingService(provider: clientProvider)
    }
    
    func makeOnboardingVM(onboardingService: OnboardingServiceType) -> OnboardingVM {
        OnboardingVM(onboardingService: onboardingService)
    }
    
    func makeOnboardingVC() -> OnboardingVC {
        let service: OnboardingServiceType = makeOnboardingService()
        let viewController = OnboardingVC.instantiate()
        viewController.viewModel = makeOnboardingVM(onboardingService: service)
        return viewController
    }
}

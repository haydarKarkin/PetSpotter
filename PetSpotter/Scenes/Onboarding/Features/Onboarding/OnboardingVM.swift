//
//  OnboardingVM.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import Foundation

protocol OnboardingVMType {
    func getCredentials()
}

class OnboardingVM: ViewModelType {
    
    private let onboardingService: OnboardingServiceType
    private let onboardingCoordinator: OnboardingCoordinatorType
    
    init(onboardingService: OnboardingServiceType, onboardingCoordinator: OnboardingCoordinatorType) {
        self.onboardingService = onboardingService
        self.onboardingCoordinator = onboardingCoordinator
    }
}

// MARK: - VM I/O
extension OnboardingVM {
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        getCredentials()
        output(Output())
    }
}

// MARK: - Logics
extension OnboardingVM: OnboardingVMType {
    
    func getCredentials() {
        self.onLoadHandling?(true)
        onboardingService.getCredentials() { [weak self] error in
            self?.onLoadHandling?(false)
            
            guard error != nil else {
                self?.onboardingCoordinator.showHome(route: .animals)
                return
            }
            self?.onboardingCoordinator.showHome(route: .favorites)
        }
    }
}

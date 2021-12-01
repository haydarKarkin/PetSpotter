//
//  OnboardingVM.swift
//  PetFinder
//
//  Created by hkarkin on 2.12.2021.
//

import Foundation

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
        output(Output())
    }
}

// MARK: - Logics
extension OnboardingVM {
    
    func getCredentials() {
        self.onLoadHandling?(true)
        onboardingService.getCredentials() { [weak self] result in
            self?.onLoadHandling?(false)
            switch result {
            case .success(let token):
                // TODO: save token, trigger coordinator
                UserDefaults.standard.set(value: token, forKey: UserDefaults.Keys.token.rawValue)
                self?.onboardingCoordinator.showHome()
            case .failure(let error):
                self?.onErrorHandling?(error)
            }
        }
    }
}

//
//  AppCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

protocol AppCoordinatorType: Coordinator {
    func showHome()
    func showOnboarding()
}

class AppCoordinator: AppCoordinatorType {
    
    private let sharedFactory: SharedFactoryType
    private let navigationController: UINavigationController
    
    lazy var homeCoordinator = sharedFactory
        .makeHomeFactory()
        .makeHomeCoordinator(navigationController: navigationController)
    
    lazy var onboardingCoordinator = sharedFactory
        .makeOnboardingFactory()
        .makeOnboardingCoordinator(navigationController: navigationController, delegate: self)
    
    init(navigationController: UINavigationController, sharedFactory: SharedFactoryType) {
        self.navigationController = navigationController
        self.sharedFactory = sharedFactory
    }
    
    func start() {
        do {
            let token = try UserDefaults.standard.getObject(forKey: UserDefaults.Keys.token.rawValue,
                                                                     castTo: Token.self)
            if token.isTokenValid() {
                showHome()
            } else {
                showOnboarding()
            }
        } catch {
            print(error.localizedDescription)
            showOnboarding()
        }
    }
    
    func showOnboarding() {
        coordinate(to: onboardingCoordinator)
    }
    
    func showHome() {
        coordinate(to: homeCoordinator)
    }
}

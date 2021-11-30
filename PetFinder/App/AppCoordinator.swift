//
//  AppCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let sharedFactory: SharedFactoryType
    
    init(window: UIWindow, sharedFactory: SharedFactoryType) {
        self.window = window
        self.sharedFactory = sharedFactory
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let animalCoordinator = sharedFactory
            .makeAnimalFactory()
            .makeAnimalCoordinator(navigationController: navigationController)
        coordinate(to: animalCoordinator)
    }
}

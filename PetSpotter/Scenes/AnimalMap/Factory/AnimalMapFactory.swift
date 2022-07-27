//
//  AnimalMapFactory.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import Foundation
import UIKit

protocol AnimalMapFactoryType {
    var sharedFactory: SharedFactoryType { get }
    func makeAnimalMapCoordinator(navigationController: UINavigationController) -> any Coordinator<AnimalMapRoute>
    func makeAnimalMapVM(animalMapCoordinator: any Coordinator<AnimalMapRoute>) -> AnimalMapVM
    func makeAnimalMapVC(animalMapCoordinator: any Coordinator<AnimalMapRoute>) -> AnimalMapVC
}

class AnimalMapFactory: AnimalMapFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
}

extension AnimalMapFactory {
    
    func makeAnimalMapCoordinator(navigationController: UINavigationController) -> any Coordinator<AnimalMapRoute> {
        AnimalMapCoordinator(navigationController: navigationController, animalMapFactory: self)
    }
    
    func makeAnimalMapVM(animalMapCoordinator: any Coordinator<AnimalMapRoute>) -> AnimalMapVM {
        let animalService = sharedFactory
            .makeServiceFactory()
            .makeAnimalService()
        return AnimalMapVM(animalService: animalService, animalMapCoordinator: animalMapCoordinator)
    }
    
    func makeAnimalMapVC(animalMapCoordinator: any Coordinator<AnimalMapRoute>) -> AnimalMapVC {
        let viewController = AnimalMapVC.instantiate()
        viewController.viewModel = makeAnimalMapVM(animalMapCoordinator: animalMapCoordinator)
        return viewController
    }
}

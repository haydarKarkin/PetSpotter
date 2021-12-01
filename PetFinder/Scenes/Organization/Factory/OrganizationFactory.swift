//
//  OrganizationFactory.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import Foundation
import UIKit

protocol OrganizationFactoryType {
    func makeOrganizationCoordinator(navigationController: UINavigationController) -> OrganizationCoordinatorType
    func makeOrganizationService() -> OrganizationServiceType
    func makeOrganizationsVM(organizationService: OrganizationServiceType) -> OrganizationsVM
    func makeOrganizationsVC() -> OrganizationsVC
}

class OrganizationFactory: OrganizationFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeOrganizationCoordinator(navigationController: UINavigationController) -> OrganizationCoordinatorType {
        OrganizationCoordinator(navigationController: navigationController, organizationFactory: self)
    }
    
    func makeOrganizationService() -> OrganizationServiceType {
        let clientProvider: ClientProvider<OrganizationAPI> = sharedFactory.makeClientProvider()
        return OrganizationService(provider: clientProvider)
    }
    
    func makeOrganizationsVM(organizationService: OrganizationServiceType) -> OrganizationsVM {
        OrganizationsVM(organizationService: organizationService)
    }
    
    func makeOrganizationsVC() -> OrganizationsVC {
        let service: OrganizationServiceType = makeOrganizationService()
        let viewController = OrganizationsVC.instantiate()
        viewController.viewModel = makeOrganizationsVM(organizationService: service)
        return viewController
    }
}

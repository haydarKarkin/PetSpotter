//
//  OrganizationFactory.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import Foundation
import UIKit

protocol OrganizationFactoryType {
    var sharedFactory: SharedFactoryType { get }
    func makeOrganizationCoordinator(navigationController: UINavigationController) -> OrganizationCoordinatorType
    func makeOrganizationsVM(organizationService: OrganizationServiceType, organizationCoordinator: OrganizationCoordinatorType) -> OrganizationsVM
    func makeOrganizationsVC(organizationCoordinator: OrganizationCoordinatorType) -> OrganizationsVC
}

class OrganizationFactory: OrganizationFactoryType {
    
    let sharedFactory: SharedFactoryType
    let serviceFactory: ServiceFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
        self.serviceFactory = sharedFactory.makeServiceFactory()
    }
    
    func makeOrganizationCoordinator(navigationController: UINavigationController) -> OrganizationCoordinatorType {
        OrganizationCoordinator(navigationController: navigationController, organizationFactory: self)
    }
    
    func makeOrganizationsVM(organizationService: OrganizationServiceType, organizationCoordinator: OrganizationCoordinatorType) -> OrganizationsVM {
        OrganizationsVM(organizationService: organizationService, organizationCoordinator: organizationCoordinator)
    }
    
    func makeOrganizationsVC(organizationCoordinator: OrganizationCoordinatorType) -> OrganizationsVC {
        let service: OrganizationServiceType = serviceFactory.makeOrganizationService()
        let viewController = OrganizationsVC.instantiate()
        viewController.viewModel = makeOrganizationsVM(organizationService: service, organizationCoordinator: organizationCoordinator)
        return viewController
    }
}

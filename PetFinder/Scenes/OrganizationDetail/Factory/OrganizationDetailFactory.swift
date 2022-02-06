//
//  OrganizationDetailFactory.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import Foundation
import UIKit

protocol OrganizationDetailFactoryType {
    var sharedFactory: SharedFactoryType { get }
    func makeOrganizationDetailCoordinator(navigationController: UINavigationController,
                                           organization: Organization) -> OrganizationDetailCoordinatorType
    func makeOrganizationDetailVM(organization: Organization, coordinator: OrganizationDetailCoordinatorType) -> OrganizationDetailVM
    func makeOrganizationDetailVC(organization: Organization, coordinator: OrganizationDetailCoordinatorType) -> OrganizationDetailVC
}

class OrganizationDetailFactory: OrganizationDetailFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeOrganizationDetailCoordinator(navigationController: UINavigationController, organization: Organization) -> OrganizationDetailCoordinatorType {
        OrganizationDetailCoordinator(navigationController: navigationController,
                                      organizationDetailFactory: self,
                                      organization: organization)
    }
    
    func makeOrganizationDetailVM(organization: Organization, coordinator: OrganizationDetailCoordinatorType) -> OrganizationDetailVM {
        OrganizationDetailVM(organization: organization,
                             organizationDetailCoordinator: coordinator)
    }
    
    func makeOrganizationDetailVC(organization: Organization, coordinator: OrganizationDetailCoordinatorType) -> OrganizationDetailVC {
        let viewController = OrganizationDetailVC.instantiate()
        viewController.viewModel = makeOrganizationDetailVM(organization: organization,
                                                            coordinator: coordinator)
        return viewController
    }
}

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
                                           organization: Organization) -> any Coordinator<OrganizationDetailRoute>
    func makeOrganizationDetailVM(organization: Organization, coordinator: any Coordinator<OrganizationDetailRoute>) -> OrganizationDetailVM
    func makeOrganizationDetailVC(organization: Organization, coordinator: any Coordinator<OrganizationDetailRoute>) -> OrganizationDetailVC
}

class OrganizationDetailFactory: OrganizationDetailFactoryType {
    
    let sharedFactory: SharedFactoryType
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
}

extension OrganizationDetailFactory {
    
    func makeOrganizationDetailCoordinator(navigationController: UINavigationController, organization: Organization) -> any Coordinator<OrganizationDetailRoute> {
        OrganizationDetailCoordinator(navigationController: navigationController,
                                      organizationDetailFactory: self,
                                      organization: organization)
    }
    
    func makeOrganizationDetailVM(organization: Organization, coordinator: any Coordinator<OrganizationDetailRoute>) -> OrganizationDetailVM {
        OrganizationDetailVM(organization: organization,
                             organizationDetailCoordinator: coordinator)
    }
    
    func makeOrganizationDetailVC(organization: Organization, coordinator: any Coordinator<OrganizationDetailRoute>) -> OrganizationDetailVC {
        let viewController = OrganizationDetailVC.instantiate()
        viewController.viewModel = makeOrganizationDetailVM(organization: organization,
                                                            coordinator: coordinator)
        return viewController
    }
}

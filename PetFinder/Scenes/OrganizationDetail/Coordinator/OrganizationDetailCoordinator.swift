//
//  OrganizationDetailCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import Foundation
import UIKit

protocol OrganizationDetailCoordinatorType: Coordinator {
}

class OrganizationDetailCoordinator: OrganizationDetailCoordinatorType {
    
    private let navigationController: UINavigationController
    private let organizationDetailFactory: OrganizationDetailFactoryType
    private let organization: Organization
    
    init(navigationController: UINavigationController,
         organizationDetailFactory: OrganizationDetailFactoryType,
         organization: Organization) {
        self.navigationController = navigationController
        self.organizationDetailFactory = organizationDetailFactory
        self.organization = organization
    }
    
    func start() {
        let viewController = organizationDetailFactory.makeOrganizationDetailVC(organization: organization)
        navigationController.pushViewController(viewController, animated: true)
    }
}

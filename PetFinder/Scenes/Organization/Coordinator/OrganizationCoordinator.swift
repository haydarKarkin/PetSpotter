//
//  OrganizationCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import Foundation
import UIKit

protocol OrganizationCoordinatorType: Coordinator {
    func showOrganizationDetail(organization: Organization)
}

class OrganizationCoordinator: OrganizationCoordinatorType {
    
    private let navigationController: UINavigationController
    private let organizationFactory: OrganizationFactoryType
    
    init(navigationController: UINavigationController, organizationFactory: OrganizationFactoryType) {
        self.navigationController = navigationController
        self.organizationFactory = organizationFactory
    }
    
    func start() {
        let viewController = organizationFactory.makeOrganizationsVC(organizationCoordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showOrganizationDetail(organization: Organization) {
        let viewController = organizationFactory.makeOrganizationDetailVC(organization: organization)
        navigationController.pushViewController(viewController, animated: true)
    }
}

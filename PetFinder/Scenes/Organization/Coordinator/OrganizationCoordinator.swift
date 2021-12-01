//
//  OrganizationCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import Foundation
import UIKit

protocol OrganizationCoordinatorType: Coordinator {
}

class OrganizationCoordinator: OrganizationCoordinatorType {
    
    private let navigationController: UINavigationController
    private let organizationFactory: OrganizationFactoryType
    
    init(navigationController: UINavigationController, organizationFactory: OrganizationFactoryType) {
        self.navigationController = navigationController
        self.organizationFactory = organizationFactory
    }
    
    func start() {
        let viewController = organizationFactory.makeOrganizationsVC()
        navigationController.pushViewController(viewController, animated: false)
    }
}

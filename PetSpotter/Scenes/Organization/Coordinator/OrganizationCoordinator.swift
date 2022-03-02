//
//  OrganizationCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import UIKit

enum OrganizationRoute: Route {
    case organizations
    case organizationDetail(Organization)
}

typealias OrganizationCoordinatorType = Coordinator<OrganizationRoute>

class OrganizationCoordinator: OrganizationCoordinatorType {
    
    private let organizationFactory: OrganizationFactoryType
    
    init(navigationController: UINavigationController, organizationFactory: OrganizationFactoryType) {
        self.organizationFactory = organizationFactory
        super.init(navigationController: navigationController, initialRoute: .organizations)
    }
    
    override func navigate(to route: OrganizationRoute) {
        switch route {
        case .organizations:
            let viewController = organizationFactory.makeOrganizationsVC(organizationCoordinator: self)
            navigationController.pushViewController(viewController, animated: true)
        case .organizationDetail(let organization):
            let _ = organizationFactory
                .sharedFactory
                .makeOrganizationDetailFactory()
                .makeOrganizationDetailCoordinator(navigationController: navigationController, organization: organization)
        }
    }
}

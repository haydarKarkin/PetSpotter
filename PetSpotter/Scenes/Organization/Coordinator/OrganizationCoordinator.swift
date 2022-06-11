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

class OrganizationCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let organizationFactory: OrganizationFactoryType
    
    init(navigationController: UINavigationController, organizationFactory: OrganizationFactoryType) {
        self.navigationController = navigationController
        self.organizationFactory = organizationFactory
    }
    
    func start() {
        navigate(to: .organizations)
    }
    
    func navigate(to route: OrganizationRoute) {
        switch route {
        case .organizations:
            let viewController = organizationFactory.makeOrganizationsVC(organizationCoordinator: self)
            navigationController.pushViewController(viewController, animated: true)
        case .organizationDetail(let organization):
            organizationFactory
                .sharedFactory
                .makeOrganizationDetailFactory()
                .makeOrganizationDetailCoordinator(navigationController: navigationController, organization: organization)
                .start()
        }
    }
}

//
//  OrganizationDetailCoordinator.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import UIKit

enum OrganizationDetailRoute: Route {
    case organizationDetail(Organization)
    case animals(String)
}

class OrganizationDetailCoordinator: Coordinator {
    
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
        navigate(to: .organizationDetail(organization))
    }
    
    func navigate(to route: OrganizationDetailRoute) {
        switch route {
        case .organizationDetail(let organization):
            let viewController = organizationDetailFactory.makeOrganizationDetailVC(organization: organization, coordinator: self)
            navigationController.pushViewController(viewController, animated: true)
        case .animals(let organizationID):
            organizationDetailFactory
                .sharedFactory
                .makeAnimalFactory()
                .makeAnimalCoordinator(navigationController: navigationController, organizationID: organizationID)
                .start()
        }
    }
}

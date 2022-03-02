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

typealias OrganizationDetailCoordinatorType = Coordinator<OrganizationDetailRoute>

class OrganizationDetailCoordinator: OrganizationDetailCoordinatorType {
    
    private let organizationDetailFactory: OrganizationDetailFactoryType
    
    init(navigationController: UINavigationController,
         organizationDetailFactory: OrganizationDetailFactoryType,
         organization: Organization) {
        self.organizationDetailFactory = organizationDetailFactory
        super.init(navigationController: navigationController, initialRoute: .organizationDetail(organization))
    }
    
    override func navigate(route: OrganizationDetailRoute) {
        switch route {
        case .organizationDetail(let organization):
            let viewController = organizationDetailFactory.makeOrganizationDetailVC(organization: organization, coordinator: self)
            navigationController.pushViewController(viewController, animated: true)
        case .animals(let organizationID):
            let _ = organizationDetailFactory
                .sharedFactory
                .makeAnimalFactory()
                .makeAnimalCoordinator(navigationController: navigationController, organizationID: organizationID)
        }
    }
}

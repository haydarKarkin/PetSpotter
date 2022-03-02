//
//  OrganizationDetailVM.swift
//  PetFinder
//
//  Created by hkarkin on 5.02.2022.
//

import Foundation

class OrganizationDetailVM: ViewModelType {
    
    private let organization: Organization
    private let organizationDetailCoordinator: OrganizationDetailCoordinatorType
    
    init(organization: Organization,
         organizationDetailCoordinator: OrganizationDetailCoordinatorType) {
        self.organization = organization
        self.organizationDetailCoordinator = organizationDetailCoordinator
    }
}

// MARK: - VM I/O
extension OrganizationDetailVM {
    struct Input {}
    
    struct Output {
        var organization: Organization
        var openAnimals: ((String) -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        let openAnimals: ((String) -> Void)? = { id in
            self.showAnimals(with: id)
        }
        output(Output(organization: organization, openAnimals: openAnimals))
    }
}

// MARK: - Logics
extension OrganizationDetailVM {
    
    func showAnimals(with id: String) {
        organizationDetailCoordinator.navigate(to: .animals(id))
    }
}

//
//  OrganizationDetailVM.swift
//  PetFinder
//
//  Created by hkarkin on 5.02.2022.
//

import Foundation

class OrganizationDetailVM: ViewModelType {
    
    private let organization: Organization
    private let animalService: AnimalServiceType
    
    init(organization: Organization,
         animalService: AnimalServiceType) {
        self.organization = organization
        self.animalService = animalService
    }
}

// MARK: - VM I/O
extension OrganizationDetailVM {
    struct Input {}
    
    struct Output {
        var organization: Organization
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        output(Output(organization: organization))
    }
}

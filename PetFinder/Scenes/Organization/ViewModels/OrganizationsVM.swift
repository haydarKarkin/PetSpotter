//
//  OrganizationsVM.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import Foundation

class OrganizationsVM: ViewModelType {
    
    private let organizationService: OrganizationServiceType
    
    init(organizationService: OrganizationServiceType) {
        self.organizationService = organizationService
    }
}

// MARK: - VM I/O
extension OrganizationsVM {
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        output(Output())
    }
}

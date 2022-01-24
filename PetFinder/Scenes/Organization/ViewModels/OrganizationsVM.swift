//
//  OrganizationsVM.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import Foundation

class OrganizationsVM: ViewModelType {
    
    private var currentPage: Int = 1
    private var organizations: [Organization] = [Organization]()
    private var totalCount: Int = 0
    
    private let organizationService: OrganizationServiceType
    
    init(organizationService: OrganizationServiceType) {
        self.organizationService = organizationService
    }
}

// MARK: - VM I/O
extension OrganizationsVM {
    struct Input {
        var organizations: (([Organization]) -> Void)?
    }
    
    struct Output {
        var next: (() -> Void)?
        var getOrganizations: (() -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        let next: (() -> Void)? = {
            self.nextPage(completion: input.organizations)
        }
        
        let getOrganizations: (() -> Void)? = {
            self.getOrganizations(completion: input.organizations)
        }
        
        output(Output(next: next, getOrganizations: getOrganizations))
    }
}

// MARK: - Logics
extension OrganizationsVM {
    
    func getOrganizations(page: Int = 1, completion: (([Organization]) -> Void)?) {
        self.onLoadHandling?(true)
        
        currentPage = page
        
        organizationService.getOrganizations(page: page) { result in
            self.onLoadHandling?(false)
            switch result {
            case .success(let resp):
                self.organizations = self.organizations + (resp.organizations ?? [])
                self.totalCount = resp.pagination?.totalCount ?? 0
                completion?(self.organizations)
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        }
    }
    
    func nextPage(completion: (([Organization]) -> Void)?) {
        if organizations.count < totalCount {
            let nextPage = currentPage + 1
            getOrganizations(page: nextPage, completion: completion)
        }
    }
}

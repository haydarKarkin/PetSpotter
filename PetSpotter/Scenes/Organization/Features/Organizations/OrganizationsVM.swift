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
    private let organizationCoordinator: OrganizationCoordinatorType
    
    init(organizationService: OrganizationServiceType,
         organizationCoordinator: OrganizationCoordinatorType) {
        self.organizationService = organizationService
        self.organizationCoordinator = organizationCoordinator
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
        var openDetail:((Organization) -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        let next: (() -> Void)? = {
            self.nextPage(completion: input.organizations)
        }
        
        let getOrganizations: (() -> Void)? = {
            self.getOrganizations(completion: input.organizations)
        }
        
        let openDetail: ((Organization) -> Void)? = { organization in
            self.showOrganizationDetail(with: organization)
        }
        
        output(Output(next: next, getOrganizations: getOrganizations, openDetail: openDetail))
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
    
    func showOrganizationDetail(with organization: Organization) {
        organizationCoordinator.navigate(to: .organizationDetail(organization))
    }
}

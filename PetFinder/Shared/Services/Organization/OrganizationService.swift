//
//  OrganizationService.swift
//  PetFinder
//
//  Created by hkarkin on 1.12.2021.
//

import Foundation

protocol OrganizationServiceType {
    func getOrganizations(page: Int, completion: @escaping(Result<Organizations, Error>) -> ())
    func getOrganization(id: String, completion: @escaping(Result<OrganizationDetail, Error>) -> ())
}

class OrganizationService: OrganizationServiceType {
    
    let provider: ClientProvider<OrganizationAPI>
    
    init(provider: ClientProvider<OrganizationAPI>) {
        self.provider = provider
    }
    
    func getOrganizations(page: Int, completion: @escaping(Result<Organizations, Error>) -> ()) {
        provider.request(target: .organizations(perPage: Configs.Network.paginationNumber,
                                          page: page),
                         responseType: Organizations.self) { result in
            
            switch result {
            case .success(let resp):
                completion(.success(resp))
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
    
    func getOrganization(id: String, completion: @escaping(Result<OrganizationDetail, Error>) -> ()) {
        provider.request(target: .organization(id: id),
                         responseType: OrganizationDetail.self) { result in
            
            switch result {
            case .success(let resp):
                completion(.success(resp))
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
}

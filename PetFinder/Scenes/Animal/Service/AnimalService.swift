//
//  AnimalService.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

protocol AnimalServiceType {
    func getAnimals(page: Int, completion: @escaping(Result<Animals, Error>) -> ())
}

class AnimalService: AnimalServiceType {
    
    let provider: ClientProvider<AnimalAPI>
    
    init(provider: ClientProvider<AnimalAPI>) {
        self.provider = provider
    }
    
    func getAnimals(page: Int, completion: @escaping(Result<Animals, Error>) -> ()) {
        provider.request(target: .animals(perPage: Configs.Network.paginationNumber,
                                          page: page),
                         responseType: Animals.self) { result in
            
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

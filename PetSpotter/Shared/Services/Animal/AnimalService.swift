//
//  AnimalService.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import Foundation

protocol AnimalServiceType {
    func getAnimals(page: Int, organizationID: String?, filter: Filter?, completion: @escaping(Result<Animals, Error>) -> ())
    func getAnimalsByLocation(location: String, completion: @escaping(Result<Animals, Error>) -> ())
    func getAnimal(id: String, completion: @escaping(Result<AnimalDetail, Error>) -> ())
    func getAnimalTypes(completion: @escaping(Result<AnimalTypes, Error>) -> ())
}

class AnimalService: AnimalServiceType {
    
    let provider: ClientProvider<AnimalAPI>
    
    init(provider: ClientProvider<AnimalAPI>) {
        self.provider = provider
    }
    
    func getAnimals(page: Int,
                    organizationID: String?,
                    filter: Filter?,
                    completion: @escaping(Result<Animals, Error>) -> ()) {
        
        provider.request(target: .animals(perPage: Configs.Network.paginationNumber,
                                          page: page,
                                          organizationID: organizationID,
                                          filter: filter),
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
    
    func getAnimalsByLocation(location: String, completion: @escaping(Result<Animals, Error>) -> ()) {
        provider.request(target: .animalsByLocation(location: location),
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
    
    func getAnimal(id: String, completion: @escaping(Result<AnimalDetail, Error>) -> ()) {
        provider.request(target: .animal(id: id),
                         responseType: AnimalDetail.self) { result in
            
            switch result {
            case .success(let resp):
                completion(.success(resp))
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
    
    func getAnimalTypes(completion: @escaping(Result<AnimalTypes, Error>) -> ()) {
        provider.request(target: .types,
                         responseType: AnimalTypes.self) { result in
            
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

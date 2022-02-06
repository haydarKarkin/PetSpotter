//
//  AnimalDetailVM.swift
//  PetFinder
//
//  Created by hkarkin on 2.02.2022.
//

import Foundation

class AnimalDetailVM: ViewModelType {
    
    private let animal: Animal
    private let favoriteService: FavoriteServiceType
    private let dataSource: DetailDataSource
   
    init(animal: Animal,
         favoriteService: FavoriteServiceType) {
        self.animal = animal
        self.favoriteService = favoriteService
        self.dataSource = DetailDataSource(animal: animal)
    }
}

// MARK: - VM I/O
extension AnimalDetailVM {
    struct Input {
        var isFavorited: ((Bool) -> Void)?
    }
    
    struct Output {
        var animal: Animal
        var dataSource: DetailDataSource
        var getFavorite: (() -> Void)?
        var saveFavorite: (() -> Void)?
        var deleteFavorite: (() -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        let getFavorite: (() -> Void)? = {
            self.getFavorite(completion: input.isFavorited)
        }
        let saveFavorite: (() -> Void)? = {
            self.saveFavorite(completion: input.isFavorited)
        }
        let deleteFavorite: (() -> Void)? = {
            self.deleteFavorite(completion: input.isFavorited)
        }
        output(Output(animal: animal,
                      dataSource: dataSource,
                      getFavorite: getFavorite,
                      saveFavorite: saveFavorite,
                      deleteFavorite: deleteFavorite))
    }
}

// MARK: - Logics
extension AnimalDetailVM {
    
    func getFavorite(completion: ((Bool) -> Void)?) {
        favoriteService.getFavorite(animal: animal) { result in
            switch result {
            case .success(let favorite):
                if favorite != nil {
                    completion?(true)
                } else {
                    completion?(false)
                }
            case .failure:
                completion?(false)
            }
        }
    }
    
    func saveFavorite(completion: ((Bool) -> Void)?) {
        favoriteService.saveFavorite(animal: animal) { result in
            completion?(result)
        }
    }
    
    func deleteFavorite(completion: ((Bool) -> Void)?) {
        favoriteService.deleteFavorite(animal: animal) { result in
            completion?(!result)
        }
    }
}

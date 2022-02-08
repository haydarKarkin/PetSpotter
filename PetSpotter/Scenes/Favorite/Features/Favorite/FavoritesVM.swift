//
//  FavoritesVM.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import Foundation

protocol FavoritesVMType {
    func getFavorites(completion: (([Favorite]) -> Void)?)
}

class FavoritesVM: ViewModelType {
    
    private let favoriteService: FavoriteServiceType
    private let favoriteCoordinator: FavoriteCoordinatorType
    private let animalService: AnimalServiceType
    
    init(favoriteService: FavoriteServiceType,
         favoriteCoordinator: FavoriteCoordinatorType,
         animalService: AnimalServiceType) {
        self.favoriteService = favoriteService
        self.favoriteCoordinator = favoriteCoordinator
        self.animalService = animalService
    }
}

// MARK: - VM I/O
extension FavoritesVM {
    struct Input {
        var favorites: (([Favorite]) -> Void)?
    }
    
    struct Output {
        var getFavorites: (() -> Void)?
        var openAnimalDetail: ((String) -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        let getFavorites: (() -> Void)? = {
            self.getFavorites(completion: input.favorites)
        }
        let openAnimalDetail: ((String) -> Void)? = { id in
            self.showAnimalDetail(with: id)
        }
        output(Output(getFavorites: getFavorites, openAnimalDetail: openAnimalDetail))
    }
}

// MARK: - Logics
extension FavoritesVM: FavoritesVMType {
    
    func getFavorites(completion: (([Favorite]) -> Void)?) {
        self.onLoadHandling?(true)
        favoriteService.getFavorites() { [weak self] result in
            guard let self = self else { return }
            self.onLoadHandling?(false)
            switch result {
            case .success(let favorites):
                completion?(favorites)
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        }
    }
    
    func showAnimalDetail(with id: String) {
        self.onLoadHandling?(true)
        animalService.getAnimal(id: id) { [weak self] result in
            guard let self = self else { return }
            self.onLoadHandling?(false)
            switch result {
            case .success(let resp):
                self.favoriteCoordinator.showAnimalDetail(animal: resp.animal)
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        }
    }
}

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
    
    init(favoriteService: FavoriteServiceType, favoriteCoordinator: FavoriteCoordinatorType) {
        self.favoriteService = favoriteService
        self.favoriteCoordinator = favoriteCoordinator
    }
}

// MARK: - VM I/O
extension FavoritesVM {
    struct Input {
        var favorites: (([Favorite]) -> Void)?
    }
    
    struct Output {
        var getFavorites: (() -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        let getFavorites: (() -> Void)? = {
            self.getFavorites(completion: input.favorites)
        }
        
        output(Output(getFavorites: getFavorites))
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
}

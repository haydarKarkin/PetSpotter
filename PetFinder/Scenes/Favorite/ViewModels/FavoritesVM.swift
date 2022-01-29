//
//  FavoritesVM.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import Foundation

protocol FavoritesVMType {
    func getFavorites()
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
    }
    
    struct Output {
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        output(Output())
    }
}

// MARK: - Logics
extension FavoritesVM: FavoritesVMType {
    
    func getFavorites() {
        self.onLoadHandling?(true)
        favoriteService.getFavorites() { [weak self] error in
            self?.onLoadHandling?(false)
        }
    }
}
